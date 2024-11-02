#include "uwb_task.h"

String DATA = "";
// Set UWB Mode
int UWB_MODE = 1; // Anchor mode by default

// Simplified Display for Single Anchor/Tag setup
void UWB_display() {
  M5.dis.fillpix(UWB_MODE == 0 ? CRGB::Green : CRGB::Red);
}

void UWB_clear() {
  if (Serial2.available()) {
    delay(3);
    DATA = Serial2.readString();
  }
  DATA = "";
  timer_flag = 0;
  timer_data = 0;
  // M5.Lcd.fillRect(0, 50, 340, 150, BLACK);

  Serial.println("UWB cleared.");
}

void UWB_readString() {
  switch (UWB_MODE) {
  case 0: // Tag mode
    if (Serial2.available()) {
      delay(20);
      DATA = Serial2.readString(); // Đọc dữ liệu từ Serial2
      Serial.print("Tag Data: ");
      Serial.println(DATA); // Xuất dữ liệu ra Serial Monitor
      timer_flag = 0;
      timer_data = 1;
    } else {
      timer_flag = 1;
    }
    if (timer_data == 0 || timer_data > 8) { // Kiểm tra kết nối với tag
      if (timer_data == 9) {
        Serial.println("Lost connection with the tag!"); // Thông báo mất kết nối
      }
      DATA = "  0 2F   "; // Dữ liệu giả lập
      timer_flag = 0;
    }
    break;

  case 1: // Anchor mode
    if (timer_data == 0 || timer_data > 70) { // Kiểm tra kết nối với tag
      if (Serial2.available()) {
        delay(2);
        DATA = Serial2.readString();           // Đọc dữ liệu từ Serial2
        Serial.println("Setup successfully!"); // Thông báo kết nối thành công
        timer_data = 1;
        timer_flag = 1;
        break;
      } else if (timer_data > 0 && Serial2.available() == 0) {
        Serial.println("Can't find the tag!!!"); // Thông báo không tìm thấy tag
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
  case 0: // Chế độ Tag
    for (int b = 0; b < 2; b++) { // Lặp lại hai lần để ổn định kết nối
      delay(50);
      Serial2.write("AT+anchor_tag=0\r\n"); // Thiết lập thiết bị làm Tag
      delay(50);
      Serial2.write("AT+interval=5\r\n"); // Đặt độ chính xác
      delay(50);
      Serial2.write("AT+switchdis=1\r\n"); // Bắt đầu đo khoảng cách
      delay(50);
      if (b == 0) {
        Serial2.write("AT+RST\r\n"); // Đặt lại thiết bị
      }
    }
    UWB_clear(); // Xóa dữ liệu
    break;

  case 1: // Chế độ Base Station
    for (int b = 0; b < 2; b++) {
      delay(50);
      Serial2.write("AT+anchor_tag=1,0"); // Thiết lập thiết bị làm Base Station
      // Serial2.print(UWB_B_NUMBER); // ID của Base Station
      Serial2.write("\r\n");
      delay(1);
      delay(50);
      if (b == 0) {
        Serial2.write("AT+RST\r\n"); // Đặt lại thiết bị
      }
    }
    UWB_clear(); // Xóa dữ liệu
    break;
  }
}

void UWB_Timer() {
  timer = timerBegin(0, 80, true);
  timerAttachInterrupt(timer, Timer0_CallBack, true);
  timerAlarmWrite(timer, 1000000, true);
  timerAlarmEnable(timer);
}