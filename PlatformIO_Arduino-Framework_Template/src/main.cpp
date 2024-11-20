// Import required libraries
#include "main.h"

void UWB_task(void *pvParameters) {
  while (1) {
    UWB_readString();
    UWB_display();
    extract_data();
    display_extractdata();
  }
}

void MQTT_task(void *pvParameters) {
  while (1) {
    MQTT_connect();
    MQTT_send_data();
  }
}

void setup() {
  // M5Atom setup
  M5.begin();
  Serial.begin(115200);

  // UWB setup
  Serial2.begin(115200, SERIAL_8N1, ATOM_RX_PIN, ATOM_TX_PIN);
  delay(100);
  UWB_setupmode();
  UWB_timer();

  // Other setup
  // WIFI_setup();

  xTaskCreate(UWB_task, "UWB_task", 4096, NULL, 1, NULL);
  // xTaskCreate(MQTT_task, "MQTT_task", 4096, NULL, 1, NULL);
}

void loop() {
  M5.update();
}