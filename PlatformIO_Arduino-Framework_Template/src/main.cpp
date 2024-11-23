// Import required libraries
#include "main.h"

void UWB_task(void *pvParameters) {
  while (1) {
    UWB_readString();
    // UWB_display();
    extract_data();
    // calc_position();
    // calc();
    // display_extractdata();
    // vTaskDelay(pdMS_TO_TICKS(2000));

    display_single(1);
  }
}

void MQTT_task(void *pvParameters) {
  while (1) {
    MQTT_connect();
    MQTT_send_data(tagposition, 1, position_uwb, 3);
    MQTT_send_data(anchorposition, 1, anchor_f1, 3);
    MQTT_send_data(anchorposition, 2, anchor_f2, 3);
    MQTT_send_data(anchorposition, 3, anchor_f3, 3);
    MQTT_send_data(anchorposition, 4, anchor_f4, 3);
    vTaskDelay(pdMS_TO_TICKS(5000));
  }
}

void setup() {
  // M5Atom setup
  M5.begin();
  Serial.begin(9600);

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