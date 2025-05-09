#include "mqtt_module.h"

WiFiClient wifi_client;
PubSubClient ps_client(wifi_client);

unsigned long last_reconnect_attempt = 0;
bool is_register_ack_received = false;
bool is_active = false;
bool is_timeout_ack_received = false;

unsigned long control_duration = 0;
unsigned long control_start_time = 0;

unsigned long last_send_time = 0;
unsigned long last_retry_time = 0;
bool is_send_timeout = false;

char register_topic[] = "uwb/register";
char acknowledge_topic[32];
char control_topic[] = "uwb/control";
char position_topic[] = "uwb/tagposition";
char timeout_topic[] = "uwb/timeout";

void MQTT_send_register_request() {
  JsonDocument doc;
  doc["tag_id"] = g_tag_id;
  doc["room_id"] = g_room_id;
  char json_buffer[128];
  serializeJson(doc, json_buffer);

  Serial.print("MQTT - Send register request: ");
  Serial.println(json_buffer);

  if (!ps_client.publish(register_topic, json_buffer)) {
    Serial.println("MQTT - Failed to send register request");
  } else {
    Serial.println("MQTT - Register request sent successfully");
  }
}

void MQTT_reconnect() {
  if (ps_client.connect(g_tag_id)) {
    Serial.println("MQTT - Successfully connected to MQTT server");
    ps_client.subscribe(acknowledge_topic);
    ps_client.subscribe(control_topic);
    MQTT_send_register_request();
  }
}

void MQTT_send_tag_data() {
  JsonDocument doc;
  doc["tag_id"] = g_tag_id;
  doc["timestamp"] = millis();
  doc["tag_x"] = 1;
  doc["tag_y"] = 2;
  doc["tag_z"] = 3;
  doc["data"] = g_data_uwb;

  char json_buffer[256];
  serializeJson(doc, json_buffer);

  Serial.print("MQTT - Send tag data: ");
  Serial.println(json_buffer);

  if (!ps_client.publish(position_topic, json_buffer)) {
    Serial.println("MQTT - Failed to send tag data");
  } else {
    Serial.println("MQTT - Tag data sent successfully");
  }
}

void MQTT_send_timeout() {
  JsonDocument doc;
  doc["tag_id"] = g_tag_id;
  doc["status"] = "timeout";

  char json_buffer[128];
  serializeJson(doc, json_buffer);

  Serial.print("MQTT - Send timeout message: ");
  Serial.println(json_buffer);

  if (!ps_client.publish(timeout_topic, json_buffer)) {
    Serial.println("MQTT - Failed to send timeout message");
  } else {
    Serial.println("MQTT - Timeout message sent successfully");
  }
}

void MQTT_callback(char *topic, byte *payload, unsigned int length) {
  payload[length] = '\0'; // Null-terminate the payload
  String message = String((char *)payload);

  Serial.print("MQTT - Received message on ");
  Serial.print(topic);
  Serial.print(": ");
  Serial.println(message);

  JsonDocument doc;
  DeserializationError error = deserializeJson(doc, message);
  if (error) {
    Serial.print(F("MQTT - Failed to parse JSON: "));
    Serial.println(error.c_str());
    return;
  }

  if (strcmp(topic, control_topic) == 0) {
    const char *active_tag = doc["active_tag"];
    if (strcmp(active_tag, g_tag_id) == 0) {
      control_duration = doc["duration"];
      control_start_time = millis();
      is_active = true;
      printTimeStamp();
      Serial.println("UWB turn on");

      Serial2.write("AT+switchdis=1\r\n");

      Serial.println("MQTT - Active");
    }
  } else if (strcmp(topic, acknowledge_topic) == 0) {
    const char *status = doc["status"];
    if ((strcmp(status, "register_ok") == 0) &&
        (is_register_ack_received == false)) {
      is_register_ack_received = true;
      Serial.println("MQTT - Successfully registered");
    } else if (strcmp(status, "timeout_ok") == 0) {
      is_timeout_ack_received = true;
      is_send_timeout = false;
      Serial.println("MQTT - Timeout acknowledged");
    }
  }
}

void MQTT_setup() {
  snprintf(acknowledge_topic, sizeof(acknowledge_topic), "uwb/ack/%s", g_tag_id);
  ps_client.setServer(MQTT_SERVER, MQTT_PORT);
  ps_client.setCallback(MQTT_callback);
}

void MQTT_processing() {
  if (!ps_client.connected()) {
    long now = millis();
    if (now - last_reconnect_attempt > 3000) {
      last_reconnect_attempt = now;
      MQTT_reconnect();
    }
    return;
  }

  ps_client.loop();

  if (is_active &&
      ((millis() - last_send_time) > MQTT_SEND_INTERVAL)) {
    MQTT_send_tag_data();
    last_send_time = millis();
  }

  if ((is_active == true) &&
      ((millis() - control_start_time) > control_duration)) {
    is_active = false;
    printTimeStamp();
    Serial.println("UWB turn off");
    Serial2.write("AT+switchdis=0\r\n");

    is_timeout_ack_received = false;
    is_send_timeout = true;
    last_retry_time = millis();
    Serial.println("MQTT - Control duration expired, stopping the tag");
    MQTT_send_timeout();
  }

  if ((is_send_timeout == true) &&
      (is_timeout_ack_received == false) &&
      ((millis() - last_retry_time) > MQTT_TIMEOUT_RETRY)) {
    if ((millis() - control_start_time) > (control_duration + MQTT_MAX_TIMEOUT_RETRY)) {
      is_send_timeout = false;
      Serial.println("MQTT - Not receive ACK timeout");
    } else {
      MQTT_send_timeout();
      last_retry_time = millis();
    }
  }
}