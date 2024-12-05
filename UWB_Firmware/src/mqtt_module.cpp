#include "mqtt_module.h"

WiFiClient client;

// Setup the MQTT client class by passing in the WiFi client and MQTT server and login details
Adafruit_MQTT_Client mqtt(&client, AIO_SERVER, AIO_SERVERPORT, AIO_USERNAME, AIO_KEY);
Adafruit_MQTT_Publish tagposition = Adafruit_MQTT_Publish(&mqtt, AIO_USERNAME "/feeds/tagposition/csv");
Adafruit_MQTT_Publish anchorposition = Adafruit_MQTT_Publish(&mqtt, AIO_USERNAME "/feeds/anchorposition/csv");


void MQTT_connect() {
  // Stop if already connected
  if (mqtt.connected()) {
    return;
  }

  Serial.println("Connecting to MQTT...");
  int8_t ret;
  uint8_t retries = MQTT_RETRIES;

  while ((ret = mqtt.connect()) != 0) { // Connect will return 0 for connected
    Serial.println(mqtt.connectErrorString(ret));
    Serial.println("Retrying MQTT connection in 5 seconds...");
    mqtt.disconnect();
    vTaskDelay(pdMS_TO_TICKS(MQTT_WAIT_RETRY)); // Wait 5 seconds
    retries--;
    if (retries == 0) {
      // Basically die and wait for WDT to reset me
      while (1)
        ;
    }
  }
  Serial.println("MQTT Connected!");
  return;
}

String formatPositionString(int id, float array[], int length) {
  String result = String(id);
  for (int i = 0; i < length; i++) {
    result += "," + String(array[i]);
  }
  return result;
}

void MQTT_send_data(Adafruit_MQTT_Publish topic, int id, float array[], int length) {
  String send_data = formatPositionString(id, array, length);
  if (!topic.publish(send_data.c_str())) {
    Serial.println("Send failed!");
  } else {
    Serial.println("Send success!");
  }
  vTaskDelay(pdMS_TO_TICKS(MQTT_WAIT_SEND));
  return;
}
