
// Import required libraries

#include "main.h"
#include <WiFi.h>
#include <time.h>

// Thông tin WiFi
const char *ssid = "Redmi Note 11";
const char *password = "531327aA";

// Cấu hình múi giờ Việt Nam
const long gmtOffset_sec = 7 * 3600; // UTC+7
const int daylightOffset_sec = 0;    // Không áp dụng giờ mùa hè

void UWB_task(void *pvParameters) {
  while (1) {
    UWB_readString();
    UWB_display();
    vTaskDelay(pdMS_TO_TICKS(100));
  }
}

void setup() {
  // M5Atom setup
  // M5.begin(true, true, true);
  AtomS3.begin(true);
  Serial.begin(115200);

  // UWB setup
  Serial2.begin(115200, SERIAL_8N1, ATOMS3_RX_PIN, ATOMS3_TX_PIN);
  delay(100);
  UWB_timer();
  UWB_setupmode();
  // Kết nối WiFi
  // WiFi.begin(ssid, password);
  // while (WiFi.status() != WL_CONNECTED) {
  //   delay(500);
  //   Serial.print(".");
  // }
  // Serial.println("\nĐã kết nối WiFi!");

  // // Cấu hình NTP server
  // configTime(gmtOffset_sec, daylightOffset_sec, "pool.ntp.org");

  // // Đợi có thời gian
  // struct tm timeinfo;
  // if (!getLocalTime(&timeinfo)) {
  //   Serial.println("Không lấy được thời gian!");
  //   return;
  // }
  // Other setup
  // WIFI_setup();

  // Create task
  xTaskCreate(UWB_task, "UWB_task", 4096, NULL, 1, NULL);
  // xTaskCreate(MQTT_tag_task, "MQTT_tag_task", 4096, NULL, 1, NULL);
  // xTaskCreate(MQTT_anchor_task, "MQTT_anchor_task", 4096, NULL, 1, NULL);

  // pinMode(21, OUTPUT);
}

void loop() {
  // if (M5.Btn.isPressed()) {
  //   M5.dis.fillpix(0xfff000);
  //   digitalWrite(21, HIGH);
  // } else {
  //   M5.dis.fillpix(0xff0000);
  //   digitalWrite(21, LOW);
  // }

  AtomS3.update();
}

/*
#include "main.h"
#include <WiFi.h>
#include <time.h>

// Thông tin WiFi
const char *ssid = "Redmi Note 11";
const char *password = "531327aA";

// Cấu hình múi giờ Việt Nam
const long gmtOffset_sec = 7 * 3600; // UTC+7
const int daylightOffset_sec = 0;    // Không áp dụng giờ mùa hè

void setup() {
  AtomS3.begin(true);
  Serial.begin(115200);

  // Kết nối WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nĐã kết nối WiFi!");

  // Cấu hình NTP server
  configTime(gmtOffset_sec, daylightOffset_sec, "pool.ntp.org");

  // Đợi có thời gian
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    Serial.println("Không lấy được thời gian!");
    return;
  }

  // In thời gian hiện tại
  Serial.print("Thời gian hiện tại: ");
  Serial.println(&timeinfo, "%Y-%m-%d %H:%M:%S");
}

void loop() {
  AtomS3.update();
  delay(1000); // In lại thời gian mỗi 10s
  struct tm timeinfo;
  if (getLocalTime(&timeinfo)) {
    Serial.print("Cập nhật thời gian: ");
    Serial.println(&timeinfo, "%Y-%m-%d %H:%M:%S");
  }
}
*/