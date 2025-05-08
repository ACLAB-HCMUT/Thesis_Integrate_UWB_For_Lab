// Import required libraries
#include "main.h"

void UWB_task(void *pvParameters) {
  while (1) {
    UWB_readString();
    UWB_display();
    vTaskDelay(pdMS_TO_TICKS(2000));
  }
}

void MQTT_task(void *pvParameters) {
  while (1) {
    MQTT_processing();
    vTaskDelay(pdMS_TO_TICKS(100));
  }
}

void setup() {
  // M5Atom setup
  M5.begin(true, true, true);
  Serial.begin(115200);

  // UWB setup
  // Serial2.begin(115200, SERIAL_8N1, ATOM_RX_PIN, ATOM_TX_PIN);
  // delay(100);
  // UWB_timer();
  // UWB_setupmode();

  // Other setup
  WIFI_setup();
  MQTT_setup();

  // Create task
  // xTaskCreate(UWB_task, "UWB_task", 4096, NULL, 1, NULL);
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