// Import required libraries
/*
#include "main.h"
// #include "M5AtomS3.h"

#define BTN_PIN 41
void UWB_task(void *pvParameters) {
  while (1) {
    UWB_readString();
    UWB_display();
    vTaskDelay(pdMS_TO_TICKS(2000));
  }
}

// void MQTT_tag_task(void *pvParameters) {
//   while (1) {
//     MQTT_connect();
//     MQTT_send_data(tagposition, 1, g_position_uwb, "tag");
//   }
// }

// void MQTT_anchor_task(void *pvParameters) {
//   while (1) {
//     MQTT_connect();
//     for (int i = 0; i < N_ANCHORS; i++) {
//       MQTT_send_data(anchorposition, i + 1, g_anchor_matrix[i], "anchor");
//     }
//   }
// }

void setup() {
  // M5Atom setup
  // M5.begin(true, false, true);
  // Serial.begin(9600);

  auto cfg = M5.config();
  AtomS3.begin(cfg, true);

  pinMode(BTN_PIN, INPUT_PULLUP);

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
  // if (M5.Btn.isPressed()) {
  //   M5.dis.fillpix(0xfff000);
  //   digitalWrite(21, HIGH);
  // } else {
  //   M5.dis.fillpix(0xff0000);
  //   digitalWrite(21, LOW);
  // }

  // delay(50);

  // M5.update();
  AtomS3.update();
  // AtomS3.dis.drawpix(0xff0000);
  // AtomS3.dis.drawpix(0x00ff00);
  if (digitalRead(BTN_PIN) == LOW) {
    AtomS3.dis.drawpix(0x00ff00);
    // Serial.println("Button pressed!");
  } else {
    AtomS3.dis.drawpix(0xff0000);
  }

  delay(50);
}
*/

/*
#include "M5AtomS3.h"

#define BTN_PIN 41

void setup() {
  // AtomS3.begin(true); // Init M5AtomS3Lite.
  // AtomS3.dis.setBrightness(100);

  auto cfg = M5.config();
  AtomS3.begin(cfg, true);

  pinMode(BTN_PIN, INPUT_PULLUP);

  Serial.begin(115200);
}

void loop() {
  AtomS3.update();
  // AtomS3.dis.drawpix(0xff0000);
  // AtomS3.dis.drawpix(0x00ff00);
  if (digitalRead(BTN_PIN) == LOW) {
    AtomS3.dis.drawpix(0x00ff00);
    // Serial.println("Button pressed!");
  } else {
    AtomS3.dis.drawpix(0xff0000);
  }

  delay(50);
}
  */

// Testing AT command activity
#include "M5Atom.h"

void setup() {
  // M5Atom setup
  M5.begin(true, true, true);
  Serial.begin(115200);

  // UWB setup
  Serial2.begin(115200, SERIAL_8N1, 32, 26);
  delay(100);
}

void loop() {
  Serial.println("AT");
  Serial.println(Serial2.write("AT\r\n"));
  Serial.println(Serial2.readString());
  delay(500);
  Serial.println("AT+switchdis=0");
  Serial.println(Serial2.write("AT+switchdis=0\r\n"));
  Serial.println(Serial2.readString());
  delay(500);
  Serial.println("AT+switchdis=1");
  Serial.println(Serial2.write("AT+switchdis=1\r\n"));
  Serial.println(Serial2.readString());
  delay(500);
  Serial.println("AT+interval=5");
  Serial.println(Serial2.write("AT+interval=5\r\n"));
  Serial.println(Serial2.readString());
  delay(500);
  Serial.println("AT+version?");
  Serial.println(Serial2.write("AT+version?\r\n"));
  Serial.println(Serial2.readString());
  delay(500);
  Serial.println("AT+RST");
  Serial.println(Serial2.write("AT+RST\r\n"));
  Serial.println(Serial2.readString());
  delay(500);
  Serial.println("AT+anchor_tag=0");
  Serial.println(Serial2.write("AT+anchor_tag=0\r\n"));
  Serial.println(Serial2.readString());
  delay(500);
  Serial.println("AT+anchor_tag=1,0");
  Serial.println(Serial2.write("AT+anchor_tag=1,0\r\n"));
  Serial.println(Serial2.readString());
  delay(500);

  M5.update();

  delay(2000);
}