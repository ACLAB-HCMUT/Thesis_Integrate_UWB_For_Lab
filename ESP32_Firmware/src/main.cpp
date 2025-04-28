// Import required libraries
#include "main.h"

/*
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
*/

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