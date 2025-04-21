// Import required libraries
/*
#include "main.h"

void UWB_task(void *pvParameters) {
  while (1) {
    UWB_readString();
    UWB_display();
    vTaskDelay(pdMS_TO_TICKS(2000));
  }
}

void MQTT_tag_task(void *pvParameters) {
  while (1) {
    MQTT_connect();
    MQTT_send_data(tagposition, 1, g_position_uwb, "tag");
  }
}

void MQTT_anchor_task(void *pvParameters) {
  while (1) {
    MQTT_connect();
    for (int i = 0; i < N_ANCHORS; i++) {
      MQTT_send_data(anchorposition, i + 1, g_anchor_matrix[i], "anchor");
    }
  }
}

void setup() {
  // M5Atom setup
  M5.begin(true, false, true);
  Serial.begin(9600);

  // UWB setup
  // Serial2.begin(115200, SERIAL_8N1, ATOM_RX_PIN, ATOM_TX_PIN);
  // delay(100);
  // UWB_timer();
  // UWB_setupmode();

  // Other setup
  // WIFI_setup();

  // Create task
  // xTaskCreate(UWB_task, "UWB_task", 4096, NULL, 1, NULL);
  // xTaskCreate(MQTT_tag_task, "MQTT_tag_task", 4096, NULL, 1, NULL);
  // xTaskCreate(MQTT_anchor_task, "MQTT_anchor_task", 4096, NULL, 1, NULL);
}

void loop() {
  if (M5.Btn.isPressed()) {
    M5.dis.fillpix(0xfff000);
    digitalWrite(21, HIGH);
  } else {
    M5.dis.fillpix(0xff0000);
    digitalWrite(21, LOW);
  }

  delay(50);

  M5.update();
}
*/
/*

#include "../project_config.h"
#include "DHT20.h"
#include "M5Atom.h"
#include <ArduinoJson.h>
#include <PubSubClient.h>
#include <WiFi.h>

// WiFi & MQTT cấu hình
const char *ssid2 = WLAN_SSID;
const char *password2 = WLAN_PASS;
const char *mqtt_server = "192.168.123.170"; // IP broker MQTT

const char *TAG_ID = "tag123";

WiFiClient espClient;
PubSubClient PSclient(espClient);

unsigned long lastReconnectAttempt = 0;
bool isAcknowledged = false;
bool isActive = false;
bool timeoutAckReceived = false;

unsigned long controlDuration = 0;
unsigned long controlStartTime = 0;

unsigned long lastSendTime = 0;
unsigned long lastRetryTime = 0;
bool retryingTimeout = false;

const unsigned long sendIntervalMs = 2000;
const unsigned long timeoutRetryMs = 1000;
const unsigned long maxTimeoutRetryMs = 6000;

void setup_wifi() {
  delay(100);
  Serial.println("Kết nối WiFi...");
  WiFi.begin(ssid2, password2);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\n✅ WiFi đã kết nối");
}

void sendRegisterRequest() {
  StaticJsonDocument<128> doc;
  doc["id"] = TAG_ID;

  char buffer[128];
  serializeJson(doc, buffer);
  PSclient.publish("uwb/register", buffer);
  Serial.println("📤 Gửi đăng ký tag");
}

void reconnect() {
  if (PSclient.connect(TAG_ID)) {
    Serial.println("🔌 MQTT kết nối thành công");
    PSclient.subscribe(("uwb/ack/" + String(TAG_ID)).c_str());
    PSclient.subscribe("uwb/control");
    sendRegisterRequest();
  }
}

void sendTagData() {
  StaticJsonDocument<256> doc;
  doc["id"] = TAG_ID;
  doc["timestamp"] = millis();
  doc["info"] = "Dữ liệu từ tag đang hoạt động";

  char buffer[256];
  serializeJson(doc, buffer);
  PSclient.publish("uwb/tagposition", buffer);
  Serial.println("📤 Gửi dữ liệu tag");
}

void sendTimeoutMessage() {
  StaticJsonDocument<128> doc;
  doc["id"] = TAG_ID;
  doc["status"] = "timeout";

  char buffer[128];
  serializeJson(doc, buffer);
  PSclient.publish("uwb/timeout", buffer);
  Serial.println("⏱️ Gửi timeout");
}

void callback(char *topic, byte *payload, unsigned int length) {
  payload[length] = '\0';
  String message = (char *)payload;

  Serial.print("📥 Nhận từ ");
  Serial.print(topic);
  Serial.print(": ");
  Serial.println(message);

  StaticJsonDocument<256> doc;
  deserializeJson(doc, payload);

  if (String(topic) == "uwb/control") {
    String activeTag = doc["activeTag"];
    if (activeTag == TAG_ID) {
      controlDuration = doc["duration"];
      controlStartTime = millis();
      isActive = true;
      Serial.println("🚦 Được kích hoạt!");
    }
  }

  if (String(topic) == "uwb/ack/" + String(TAG_ID)) {
    String status = doc["status"];
    if (status == "ok" && !isAcknowledged) {
      isAcknowledged = true;
      Serial.println("✅ Đăng ký thành công");
    } else if (status == "received timeout") {
      timeoutAckReceived = true;
      retryingTimeout = false;
      Serial.println("✅ Đã xác nhận timeout từ server");
    }
  }
}

void setup() {
  // M5Atom setup
  M5.begin(true, false, true);
  Serial.begin(9600);

  setup_wifi();
  PSclient.setServer(mqtt_server, 1883);
  PSclient.setCallback(callback);
}

void loop() {
  if (!PSclient.connected()) {
    long now = millis();
    if (now - lastReconnectAttempt > 3000) {
      lastReconnectAttempt = now;
      reconnect();
    }
    return;
  }

  PSclient.loop();

  // Gửi dữ liệu định kỳ nếu đang active
  if (isActive && millis() - lastSendTime > sendIntervalMs) {
    sendTagData();
    lastSendTime = millis();
  }

  // Nếu hết thời gian điều khiển, gửi timeout
  if (isActive && millis() - controlStartTime > controlDuration) {
    isActive = false;
    Serial.println("⛔ Hết thời gian hoạt động");

    timeoutAckReceived = false;
    retryingTimeout = true;
    lastRetryTime = millis();
    sendTimeoutMessage();
  }

  // Retry gửi timeout nếu chưa nhận ack
  if (retryingTimeout && !timeoutAckReceived && millis() - lastRetryTime > timeoutRetryMs) {
    if (millis() - controlStartTime > controlDuration + maxTimeoutRetryMs) {
      Serial.println("🛑 Không nhận được ack timeout, dừng gửi lại.");
      retryingTimeout = false;
    } else {
      sendTimeoutMessage();
      lastRetryTime = millis();
    }
  }
}
*/

#include <M5AtomS3.h>

void setup() {
  AtomS3.begin(true); // Init M5AtomS3Lite.
  AtomS3.dis.setBrightness(100);
}

void loop() {
  AtomS3.dis.drawpix(0xff0000);
  AtomS3.update();
  delay(500);
  AtomS3.dis.drawpix(0x00ff00);
  AtomS3.update();
  delay(500);
  AtomS3.dis.drawpix(0x0000ff);
  AtomS3.update();
  delay(500);
}