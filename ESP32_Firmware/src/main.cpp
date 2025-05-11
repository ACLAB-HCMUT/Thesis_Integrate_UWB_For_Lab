// Import required libraries
#include "main.h"

#include <time.h>

void UWB_task(void *pvParameters) {
  while (1) {
    UWB_readString();
    UWB_display();
    vTaskDelay(pdMS_TO_TICKS(500));
  }
}

void MQTT_task(void *pvParameters) {
  while (1) {
    MQTT_processing();
    vTaskDelay(pdMS_TO_TICKS(100));
  }
}

// Cấu hình múi giờ Việt Nam
const long gmtOffset_sec = 7 * 3600; // UTC+7
const int daylightOffset_sec = 0;    // Không áp dụng giờ mùa hè

void setup() {
  // M5Atom setup
  M5.begin(true, true, true);
  Serial.begin(115200);

  // UWB setup
  Serial2.begin(115200, SERIAL_8N1, ATOM_RX_PIN, ATOM_TX_PIN);
  delay(100);
  UWB_timer();
  UWB_setupmode();

  // Other setup
  WIFI_setup();
  MQTT_setup();

   // Cấu hình NTP server
   configTime(gmtOffset_sec, daylightOffset_sec, "pool.ntp.org");

   // Đợi có thời gian
   struct tm timeinfo;
   if (!getLocalTime(&timeinfo)) {
     Serial.println("Không lấy được thời gian!");
     return;
   }

  // Create task
  xTaskCreate(UWB_task, "UWB_task", 4096, NULL, 1, NULL);
  xTaskCreate(MQTT_task, "MQTT_task", 4096, NULL, 1, NULL);
  // xTaskCreate(MQTT_anchor_task, "MQTT_anchor_task", 4096, NULL, 1, NULL);
}

void loop() {
  M5.update();

  if (M5.Btn.isPressed()) {
    M5.dis.fillpix(CRGB::Green);
  } else {
    M5.dis.fillpix(CRGB::LightSkyBlue);
  }

  delay(50);
}