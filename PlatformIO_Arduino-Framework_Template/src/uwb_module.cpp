#include "uwb_module.h"

String DATA = ""; // Used to store distance data
int UWB_MODE = 0; // Set UWB Mode: Tag mode is 0, Base station mode is 1
int UWB_T_NUMBER = 0; // Store the number of base stations
int UWB_B_NUMBER = 0; // Base station ID1~ID4 

// Data clear
void UWB_clear()
{
  Serial.println(Serial2.available());
  if (Serial2.available())
  {
    delay(3);
    DATA = Serial2.readString();
    Serial.print("if:");
    Serial.println(Serial2.available());
  }
  DATA = "";
  timer_flag = 0;
  timer_data = 0;
  Serial.println("UWB data cleared.");
  Serial.println(Serial2.available());
}

// UWB Setup for Tag or Anchor
void UWB_setupmode()
{
  switch (UWB_MODE)
  {
  case 0: // Tag mode
    for (int b = 0; b < 2; b++)
    { // Repeat twice to stabilize the connection
      delay(50);
      Serial2.write("AT+anchor_tag=0\r\n"); // Set device as Tag
      delay(50);
      Serial2.write("AT+interval=5\r\n"); // Set the calculation precision
      delay(50);
      Serial2.write("AT+switchdis=1\r\n"); // Start measuring distance
      delay(50);
      if (b == 0)
      {
        Serial2.write("AT+RST\r\n"); // Reset device
      }
    }
    UWB_clear(); // Delete data
    Serial.println("UWB setup mode tag.");
    break;

  case 1: // Base station mode
    for (int b = 0; b < 2; b++)
    {
      delay(50);
      Serial2.write("AT+anchor_tag=1,"); // Set up the device as a Base station
      Serial2.print(UWB_B_NUMBER);       // Base station ID
      Serial2.write("\r\n");
      delay(1);
      delay(50);
      if (b == 0)
      {
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

void UWB_Timer()
{
  timer = timerBegin(0, 80, true);
  timerAttachInterrupt(timer, Timer0_CallBack, true);
  timerAlarmWrite(timer, 1000000, true);
  timerAlarmEnable(timer);
  Serial.println("UWB setup timer.");
}

void UWB_Keyscan() {
  if (M5.Btn.isPressed()) {
    Serial2.write("AT+RST\r\n");
    UWB_setupmode();
    UWB_clear();
    Serial.println("UWB reset.");
  }
}

// Read UART data
void UWB_readString() {
  switch (UWB_MODE) {
  case 0: // Tag mode
    if (Serial2.available()) {
      delay(20);
      UWB_T_NUMBER = (Serial2.available() / 11); // Count the number of base stations
      delay(20);
      Serial.print("Number of base stations: ");
      Serial.println(UWB_T_NUMBER);
      DATA = Serial2.readString(); // Read data from Serial2
      delay(2);
      timer_flag = 0;
      timer_data = 1;
      break;
    } else {
      timer_flag = 1;
    }
    if (timer_data == 0 || timer_data > 8) { // Check connection with base station
      if (timer_data == 9) {
        Serial.println("Lost connection with the tag!"); // Disconnection notification
      }
      DATA = "  0 2F   "; // Simulation data
      timer_flag = 0;
    }
    break;

  case 1: // Base station mode
    if (timer_data == 0 || timer_data > 70) { // Check connection with tag
      if (Serial2.available()) {
        delay(2);
        DATA = Serial2.readString(); // Read data from Serial2
        DATA = "Set up successfully!";
        timer_data = 1;
        timer_flag = 1;
        break;
      } else if (timer_data > 0 && Serial2.available() == 0) {
        DATA = "Can't find the tag!!!";
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
    Serial.println(UWB_T_NUMBER);
    Serial.print("Distance: ");
    DATA = Serial2.readString();
    Serial.println(DATA);
    // if (UWB_T_NUMBER > 0 && UWB_T_NUMBER < 5) {
    //   int c = UWB_T_NUMBER; // Number of base stations
    //   while (c > 0) {
    //     c--;
    //     Serial.print("Distance: ");
    //     Serial.println(DATA);
    //   }
    // }
    break;

  case 1: // Base station mode
    Serial.print("Base station ");
    Serial.print(UWB_B_NUMBER);
    Serial.print(" data: ");
    Serial.println(DATA); // Display data in Base station mode
    break;
  }
}