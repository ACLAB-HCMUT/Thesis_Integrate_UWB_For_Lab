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