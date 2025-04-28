
#include "uwb_module.h"
#include <time.h>

void printTimeStamp() {
  struct tm timeinfo;
  if (getLocalTime(&timeinfo)) {
    Serial.printf("[%04d-%02d-%02d %02d:%02d:%02d] ",
                  timeinfo.tm_year + 1900, timeinfo.tm_mon + 1, timeinfo.tm_mday,
                  timeinfo.tm_hour, timeinfo.tm_min, timeinfo.tm_sec);
  } else {
    Serial.print("[Time unknown] ");
  }
}
int UWB_MODE = 0;     // Set UWB Mode: Tag mode is 0, Base station mode is 1
int UWB_T_NUMBER = 0; // Store the number of base stations
int UWB_T_ID = 2;     // Tag ID
int UWB_B_ID = 0;     // Base station ID1~ID4

// Private function for checking AT response
void printForDebug(size_t send, String content, String cases = "") {
  if (cases == "") {
  } else {
    Serial.println(cases);
  }
  Serial.print("Send: ");
  Serial.print(send);
  Serial.print(": ");
  Serial.println(content);
  String res = Serial2.readString();
  Serial.print("Receive: ");
  Serial.println(res);
}

// Data clear
void UWB_clear() {
  if (Serial2.available()) {
    vTaskDelay(pdMS_TO_TICKS(3));
    g_data_uwb = Serial2.readString();
  }
  g_data_uwb = "";
  timer_flag = 0;
  timer_data = 0;
  Serial.println("UWB data cleared");
}

// UWB setup for Tag or Anchor
void UWB_setupmode() {
  switch (UWB_MODE) {
  case 0:                         // Tag mode
    for (int b = 0; b < 2; b++) { // Repeat twice to stabilize the connection
      vTaskDelay(pdMS_TO_TICKS(50));
      Serial2.write("AT+anchor_tag=0,"); // Set device as Tag
      Serial2.print(UWB_T_ID);
      Serial2.write("\r\n");
      printForDebug(21, "AT+anchor_tag=0,2");

      vTaskDelay(pdMS_TO_TICKS(50));
      size_t send_inter = Serial2.write("AT+interval=5\r\n"); // Set the calculation precision
      printForDebug(send_inter, "AT+interval=5");

      vTaskDelay(pdMS_TO_TICKS(50));
      size_t send_swis = Serial2.write("AT+switchdis=1\r\n"); // Start measuring distance
      printForDebug(send_swis, "AT+switchdis=1");

      vTaskDelay(pdMS_TO_TICKS(50));
      if (b == 0) {
        size_t send_rst = Serial2.write("AT+RST\r\n"); // Reset device
        printForDebug(send_rst, "AT+RST", "Tag - When b == 0");
      }
    }
    UWB_clear(); // Delete data remaining in Serial2 buffer
    Serial.println("UWB setup mode tag");
    break;

  case 1: // Base station mode
    for (int b = 0; b < 2; b++) {
      vTaskDelay(pdMS_TO_TICKS(50));
      Serial2.write("AT+anchor_tag=1,"); // Set up the device as a Base station
      Serial2.print(UWB_B_ID);           // Base station ID
      Serial2.write("\r\n");
      printForDebug(19, "AT+anchor_tag=1," + String(UWB_B_ID));

      vTaskDelay(pdMS_TO_TICKS(1));
      vTaskDelay(pdMS_TO_TICKS(50));
      if (b == 0) {
        size_t send_rst = Serial2.write("AT+RST\r\n"); // Reset device
        printForDebug(send_rst, "AT+RST", "Base station - When b == 0");
      }
    }
    UWB_clear(); // Delete data remaining in Serial2 buffer
    Serial.println("UWB setup mode base station");
    break;

  default:
    Serial.println("UWB mode invalid");
    break;
  }
}

// Set up timer
void UWB_timer() {
  timer = timerBegin(0, 80, true); // Timer setting
  timerAttachInterrupt(timer, Timer0_CallBack, true);
  timerAlarmWrite(timer, 1000000, true);
  timerAlarmEnable(timer);
  Serial.println("UWB setup timer");
}

// Press back button to setupmode and clear
void UWB_keyscan() {
  // if (M5.Btn.isPressed()) {
  //   size_t send_rst = Serial2.write("AT+RST\r\n");
  //   printForDebug(send_rst, "AT+RST", "Back button pressed");

  //   UWB_setupmode();
  //   UWB_clear();
  //   Serial.println("UWB reset");
  // }
}

// Read UART data
void UWB_readString() {
  switch (UWB_MODE) {
  case 0: // Tag mode
    if (Serial2.available()) {
      vTaskDelay(pdMS_TO_TICKS(20));
      UWB_T_NUMBER = (Serial2.available() / 11); // Count the number of base stations
      vTaskDelay(pdMS_TO_TICKS(20));
      g_data_uwb = Serial2.readString(); // Read data from Serial2
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
      g_data_uwb = "  0 2F   "; // Simulation data
      timer_flag = 0;
    }
    break;

  case 1:                                     // Base station mode
    if (timer_data == 0 || timer_data > 70) { // Check connection with tag
      if (Serial2.available()) {
        vTaskDelay(pdMS_TO_TICKS(2));
        g_data_uwb = Serial2.readString(); // Read data from Serial2
        g_data_uwb = "Set up successfully!";
        timer_data = 1;
        timer_flag = 1;
        break;
      } else if (timer_data > 0 && Serial2.available() == 0) {
        g_data_uwb = "Can't find the tag!!!";
        timer_flag = 0;
        break;
      }
    }
    break;
  }
}

void UWB_display() {
  switch (UWB_MODE) {
  case 0: { // Tag mode
    // Serial.print("Number of base stations: ");
    // Serial.println(UWB_T_NUMBER);
    // // printTimeStamp();
    // Serial.println("Distance:");
    // Serial.println(g_data_uwb);
    String raw = g_data_uwb;
    int colonIndex = raw.indexOf(':');
    int mIndex = raw.indexOf('m');
    if (colonIndex != -1 && mIndex != -1) {
      String value = raw.substring(colonIndex + 1, mIndex);
      Serial.println(value); // In ra chỉ "0.81"
    }
    break;
  }
  case 1: // Base station mode
    Serial.print("Base station ");
    Serial.print(UWB_B_ID);
    Serial.print(" g_data_uwb: ");
    Serial.println(g_data_uwb); // Display data in Base station mode
    break;
  }
}