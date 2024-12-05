#include "uwb_module.h"

int UWB_MODE = 0;     // Set UWB Mode: Tag mode is 0, Base station mode is 1
int UWB_T_NUMBER = 0; // Store the number of base stations
int UWB_B_NUMBER = 0; // Base station ID1~ID4

// Data clear
void UWB_clear() {
  if (Serial2.available()) {
    vTaskDelay(pdMS_TO_TICKS(3));
    data_uwb = Serial2.readString();
  }
  data_uwb = "";
  timer_flag = 0;
  timer_data = 0;
  Serial.println("UWB data cleared");
}

// UWB Setup for Tag or Anchor
void UWB_setupmode() {
  switch (UWB_MODE) {
  case 0:                         // Tag mode
    for (int b = 0; b < 2; b++) { // Repeat twice to stabilize the connection
      vTaskDelay(pdMS_TO_TICKS(50));
      Serial2.write("AT+anchor_tag=0\r\n"); // Set device as Tag
      vTaskDelay(pdMS_TO_TICKS(50));
      Serial2.write("AT+interval=5\r\n"); // Set the calculation precision
      vTaskDelay(pdMS_TO_TICKS(50));
      Serial2.write("AT+switchdis=1\r\n"); // Start measuring distance
      vTaskDelay(pdMS_TO_TICKS(50));
      if (b == 0) {
        Serial2.write("AT+RST\r\n"); // Reset device
      }
    }
    UWB_clear(); // Delete data
    Serial.println("UWB setup mode tag");
    break;

  case 1: // Base station mode
    for (int b = 0; b < 2; b++) {
      vTaskDelay(pdMS_TO_TICKS(50));
      Serial2.write("AT+anchor_tag=1,"); // Set up the device as a Base station
      Serial2.print(UWB_B_NUMBER);       // Base station ID
      Serial2.write("\r\n");
      vTaskDelay(pdMS_TO_TICKS(1));
      vTaskDelay(pdMS_TO_TICKS(50));
      if (b == 0) {
        Serial2.write("AT+RST\r\n"); // Reset device
      }
    }
    UWB_clear(); // Delete data
    Serial.println("UWB setup mode base station");
    break;

  default:
    Serial.println("UWB mode invalid");
    break;
  }
}

void UWB_timer() {
  timer = timerBegin(0, 80, true);
  timerAttachInterrupt(timer, Timer0_CallBack, true);
  timerAlarmWrite(timer, 1000000, true);
  timerAlarmEnable(timer);
  Serial.println("UWB setup timer");
}

void UWB_keyscan() {
  if (M5.Btn.isPressed()) {
    Serial2.write("AT+RST\r\n");
    UWB_setupmode();
    UWB_clear();
    Serial.println("UWB reset");
  }
}

// Read UART data
void UWB_readString() {
  switch (UWB_MODE) {
  case 0: // Tag mode
    if (Serial2.available()) {
      vTaskDelay(pdMS_TO_TICKS(20));
      UWB_T_NUMBER = (Serial2.available() / 11); // Count the number of base stations
      vTaskDelay(pdMS_TO_TICKS(20));
      // Serial.print("Number of base stations: ");
      // Serial.println(UWB_T_NUMBER);
      data_uwb = Serial2.readString(); // Read data from Serial2
      // Serial.println("Distance:");
      // Serial.println(data_uwb);
      vTaskDelay(pdMS_TO_TICKS(2));
      timer_flag = 0;
      timer_data = 1;
      break;
    } else {
      timer_flag = 1;
    }
    if (timer_data == 0 || timer_data > 8) { // Check connection with base station
      if (timer_data == 9) {
        Serial.println("Lost connection with the base station!"); // Disconnection notification
      }
      data_uwb = "  0 2F   "; // Simulation data
      timer_flag = 0;
    }
    break;

  case 1:                                     // Base station mode
    if (timer_data == 0 || timer_data > 70) { // Check connection with tag
      if (Serial2.available()) {
        vTaskDelay(pdMS_TO_TICKS(2));
        data_uwb = Serial2.readString(); // Read data from Serial2
        data_uwb = "Set up successfully!";
        timer_data = 1;
        timer_flag = 1;
        break;
      } else if (timer_data > 0 && Serial2.available() == 0) {
        data_uwb = "Can't find the tag!!!";
        timer_flag = 0;
        break;
      }
    }
    break;
  }
}

void UWB_display() {
  switch (UWB_MODE) {
  case 0: // Tag mode
    break;

  case 1: // Base station mode
    Serial.print("Base station ");
    Serial.print(UWB_B_NUMBER);
    Serial.print(" data_uwb: ");
    Serial.println(data_uwb); // Display data in Base station mode
    break;
  }
}