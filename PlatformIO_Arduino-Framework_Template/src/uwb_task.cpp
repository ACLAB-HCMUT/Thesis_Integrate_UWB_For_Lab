#include "uwb_task.h"

String DATA = "";
int UWB_MODE = 1; // Set UWB Mode, Base station mode is 1
int UWB_T_UI_NUMBER_2 = 0; // Flag bit
int UWB_T_UI_NUMBER_1 = 0;
int UWB_T_NUMBER = 0;
int UWB_B_NUMBER = 2; // UWB_B_NUMBER is base station ID1~ID4 

// Data clear
void UWB_clear() {
  if (Serial2.available()) {
    delay(3);
    DATA = Serial2.readString();
  }
  DATA = "";
  timer_flag = 0;
  timer_data = 0;
  Serial.println("UWB data cleared.");
}

// Read UART data
void UWB_readString() {
  switch (UWB_MODE) {
  case 0: // Tag mode
    if (Serial2.available()) {
      delay(20);
      UWB_T_NUMBER = (Serial2.available() / 11); // Count the number of base stations
      delay(20);
      if (UWB_T_NUMBER != UWB_T_UI_NUMBER_1 || UWB_T_UI_NUMBER_2 == 0) {  
        UWB_T_UI_NUMBER_1 = UWB_T_NUMBER;
        UWB_T_UI_NUMBER_2 = 1;

        // Display tag mode info on Serial
        Serial.print("Tag mode: Number of base stations: ");
        Serial.println(UWB_T_NUMBER);
      }
      DATA = Serial2.readString(); // Read data from Serial2
      timer_flag = 0;
      timer_data = 1;
    } else {
      timer_flag = 1;
    }
    if (timer_data == 0 || timer_data > 8) { // Check connection with base station
      if (timer_data == 9) {
        Serial.println("Lost connection with the tag!"); // Disconnection notification
      }
      DATA = "  0 2F   "; // Dữ liệu giả lập
      timer_flag = 0;
    }
    break;

  case 1: // Base station mode
    if (timer_data == 0 || timer_data > 70) { // Check connection with tag
      if (Serial2.available()) {
        delay(2);
        DATA = Serial2.readString(); // Read data from Serial2
        Serial.println("Set up successfully!");
        timer_data = 1;
        timer_flag = 1;
        break;
      } else if (timer_data > 0 && Serial2.available() == 0) {
        Serial.println("Can't find the tag!!!");
        timer_flag = 0;
        break;
      }
    }
    break;
  }
}

// UWB Setup for Tag or Anchor
void UWB_setupmode() {
  switch (UWB_MODE) {
  case 0: // Tag mode
    for (int b = 0; b < 2; b++) { // Repeat twice to stabilize the connection
      delay(50);
      Serial2.write("AT+anchor_tag=0\r\n"); // Set device as Tag
      delay(50);
      Serial2.write("AT+interval=5\r\n"); // Set the calculation precision
      delay(50);
      Serial2.write("AT+switchdis=1\r\n"); // Start measuring distance
      delay(50);
      if (b == 0) {
        Serial2.write("AT+RST\r\n"); // Reset device
      }
    }
    UWB_clear(); // Delete data
    Serial.println("UWB setup mode tag.");
    break;

  case 1: // Base station mode
    for (int b = 0; b < 2; b++) {
      delay(50);
      Serial2.write("AT+anchor_tag=1,"); // Set up the device as a Base station
      Serial2.print(UWB_B_NUMBER); // Base station ID
      Serial2.write("\r\n");
      delay(1);
      delay(50);
      if (b == 0) {
        Serial2.write("AT+RST\r\n"); // Reset device
      }
    }
    UWB_clear(); // Delete data
    Serial.println("UWB setup mode base station.");
    break;

  default:
    Serial.println("UWB mode invalid.");
    break;
  }
}

void UWB_Timer() {
  timer = timerBegin(0, 80, true);
  timerAttachInterrupt(timer, Timer0_CallBack, true);
  timerAlarmWrite(timer, 1000000, true);
  timerAlarmEnable(timer);
  Serial.println("UWB setup timer.");
}

void UWB_display() {
  switch (UWB_MODE) {
  case 0: // Tag mode
    if (UWB_T_NUMBER > 0 && UWB_T_NUMBER < 5) {
      int c = UWB_T_NUMBER; // Number of base stations
      // int b = 4 - UWB_T_NUMBER;
      // while (c > 0) {
      //     c--;
        Serial.print("Tag serial number: ");
        Serial2.write("AT+version?\r\n");
        DATA = Serial2.readString();
        Serial.println(DATA);  // Tag serial number
        Serial.print("Distance: ");
        DATA = Serial2.readString();
        Serial.println(DATA);  // Distance
      // }
      // while (b > 0) {
      //     b--;
      //     Serial.println("Clearing remaining data slots...");
      // }
    }
    break;

  case 1: // Base station mode
    if (UWB_B_NUMBER == 1) {
      Serial.println("Base station data: ");
      Serial.println(DATA); // Display data in Base station mode
    }
    break;
  }
}

// UI display via Serial
void UWB_ui_display() {
  Serial.println("UWB Example");
  Serial.println("Tag: Press BtnA");
  Serial.println("Base: Press BtnB");
  Serial.println("Reset: Press BtnC");

  switch (UWB_MODE) {
  case 0: // Tag mode UI display
    if (UWB_T_NUMBER > 0 && UWB_T_NUMBER < 5) {
      int c = UWB_T_NUMBER; // Number of base stations
      int b = 4 - UWB_T_NUMBER; // Number of spare slots
      while (c > 0) {
        c--;
        Serial.print("Tag ");
        Serial.print(c + 1); // Tag number
        Serial.print(" - Distance: ");
        Serial.println("M"); // Example distance
      }
      while (b > 0) {
        b--;
        Serial.println("Clearing additional data slots...");
      }
    }
    break;

  case 1: // Base station mode UI display
    Serial.print("Base station ID: ");
    Serial.println(UWB_B_NUMBER);
    if (UWB_B_NUMBER == 0) {
      Serial.println("Loading...");
    } else {
      Serial.println("Data loaded successfully.");
    }
    break;
  }
}