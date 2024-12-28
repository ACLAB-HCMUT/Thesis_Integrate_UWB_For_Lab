// Import required libraries
#include "main.h"

void UWB_task(void *pvParameters) {
  while (1) {
    UWB_readString();
    // UWB_display();
    // extract_data();
    calc_position();
    // calc();
    display_extractdata();
    // vTaskDelay(pdMS_TO_TICKS(2000));

    display_single(1);
  }
}

void MQTT_tag_task(void *pvParameters) {
  while (1) {
    MQTT_connect();
    MQTT_send_data(tagposition, 1, position_uwb, "tag");
  }
}

void MQTT_anchor_task(void *pvParameters) {
  while (1) {
    MQTT_connect();
    for (int i = 0; i < N_ANCHORS; i++) {
      MQTT_send_data(anchorposition, i + 1, anchor_matrix[i], "anchor");
    }
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
  WIFI_setup();

  xTaskCreate(UWB_task, "UWB_task", 4096, NULL, 1, NULL);
  xTaskCreate(MQTT_tag_task, "MQTT_tag_task", 4096, NULL, 1, NULL);
  xTaskCreate(MQTT_anchor_task, "MQTT_anchor_task", 4096, NULL, 1, NULL);
}

void loop() {
  M5.update();
}