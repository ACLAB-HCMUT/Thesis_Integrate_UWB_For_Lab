// Import required libraries
#include "main.h"

// HardwareSerial UWB(1);

void UWB_Task(void *pvParameters) {
  while (1) {
    UWB_readString();
    UWB_display();

    // Serial.print("UWB Task Stack high water mark: ");
    // Serial.println(uxTaskGetStackHighWaterMark(NULL));
  }
}

void MQTT_Task(void *pvParameters) {
  while (1) {
    MQTT_connect();
    MQTT_send_data();
  }
}

void setup() {
  // pinMode(ledPin, OUTPUT);

  // // Create tasks for Wi-Fi and server
  // xTaskCreate(wifiTask, "WiFiTask", 4096, NULL, 1, NULL);
  // xTaskCreate(serverTask, "ServerTask", 8192, NULL, 1, NULL);
  // // Khởi tạo M5Atom và Serial Monitor
  // M5.begin(true, false, true);
  // M5.dis.clear(); // Xóa LED

  // // Kết nối tới Wi-Fi
  // WiFi.begin(ssid, password);
  // Serial.print("Connecting to WiFi: ");
  // Serial.println(ssid);

  // int retryCount = 0;
  // while (WiFi.status() != WL_CONNECTED)
  // {
  //   // Nếu Wi-Fi chưa kết nối, đèn LED hiển thị màu đỏ và in thông báo lên Serial Monitor
  //   M5.dis.fillpix(CRGB::Red); // Hiển thị đèn màu đỏ khi kết nối thất bại
  //   delay(1000);
  //   Serial.print(".");
  //   retryCount++;

  //   // Thử kết nối lại sau 10 lần (tùy chỉnh theo yêu cầu)
  //   if (retryCount > 10)
  //   {
  //     Serial.println("Failed to connect to WiFi");
  //     break;
  //   }
  // }

  // if (WiFi.status() == WL_CONNECTED)
  // {
  //   Serial.println("WiFi connected successfully");
  //   Serial.print("IP Address: ");
  //   Serial.println(WiFi.localIP());

  //   // Hiển thị đèn LED màu xanh khi kết nối thành công
  //   M5.dis.fillpix(CRGB::Green);
  // }
  // else
  // {
  //   Serial.println("WiFi connection failed. Check your network credentials.");
  // }

  M5.begin();
  Serial.begin(9600);
  Serial2.begin(115200, SERIAL_8N1, ATOM_RX_PIN, ATOM_TX_PIN);

  delay(100);
  UWB_setupmode();
  UWB_Timer();
  SPIFFS.begin();
  if (!SPIFFS.begin(true)) {
    Serial.println("SPIFFS Mount Failed");
    return;
  } else {
    Serial.println("SPIFFS initialized.");
  }

  WIFI_setup();
  xTaskCreate(UWB_Task, "UWB_Task", 4096, NULL, 1, NULL);
  xTaskCreate(MQTT_Task, "MQTT_Task", 4096, NULL, 1, NULL);
}

void loop() {
  M5.update();
  // MQTT_connect();
  // MQTT_send_data();
  // UWB_readString();
  // UWB_display();
}