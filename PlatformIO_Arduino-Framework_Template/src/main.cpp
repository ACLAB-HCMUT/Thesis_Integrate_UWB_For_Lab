
// Import required libraries
#include "WiFi.h"
#include "ESPAsyncWebServer.h"
#include "SPIFFS.h"
#include "DHT20.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "../project_config.h"
#include "M5Atom.h"
// #include "HardwareSerial.h"

// HardwareSerial UWB(1);

// Replace with your network credentials
// const char* ssid = PROJECT_WIFI_SSID;
// const char* password = PROJECT_WIFI_PASSWORD;

const char *ssid = PROJECT_WIFI_SSID;
const char *password = PROJECT_WIFI_PASSWORD;

String DATA = "";
// Set UWB Mode
int UWB_MODE = 1; // Anchor mode by default

hw_timer_t *timer = NULL;
int timer_flag = 0;
uint32_t timer_data = 0;

// Set LED GPIO
const int ledPin = 13;
// Stores LED state
String ledState;

// Create AsyncWebServer object on port 80
AsyncWebServer server(80);

// Replaces placeholder with LED state value
String processor(const String &var)
{
  Serial.println(var);
  if (var == "STATE")
  {
    if (digitalRead(ledPin))
    {
      ledState = "ON";
    }
    else
    {
      ledState = "OFF";
    }
    Serial.print(ledState);
    return ledState;
  }
  return String();
}

// Task to handle Wi-Fi connection
void wifiTask(void *pvParameters)
{
  Serial.begin(115200);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    vTaskDelay(1000 / portTICK_PERIOD_MS);
    Serial.println("Connecting to WiFi..");
  }

  // Print ESP32 Local IP Address
  Serial.println(WiFi.localIP());
  vTaskDelete(NULL); // Delete the task when done
}

// Task to handle server
void serverTask(void *pvParameters)
{
  // Initialize SPIFFS
  if (!SPIFFS.begin(true))
  {
    Serial.println("An Error has occurred while mounting SPIFFS");
    vTaskDelete(NULL); // Delete the task if SPIFFS initialization fails
  }

  // Route for root / web page
  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send(SPIFFS, "/index.html", String(), false, processor); });

  // Route to load style.css file
  server.on("/style.css", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send(SPIFFS, "/style.css", "text/css"); });

  // Route to set GPIO to HIGH
  server.on("/on", HTTP_GET, [](AsyncWebServerRequest *request)
            {
    digitalWrite(ledPin, HIGH);    
    request->send(SPIFFS, "/index.html", String(), false, processor); });

  // Route to set GPIO to LOW
  server.on("/off", HTTP_GET, [](AsyncWebServerRequest *request)
            {
    digitalWrite(ledPin, LOW);    
    request->send(SPIFFS, "/index.html", String(), false, processor); });

  // Start server
  server.begin();
  vTaskDelete(NULL); // Delete the task when done
}

static void IRAM_ATTR Timer0_CallBack(void)
{
  if (timer_flag == 1)
  {
    timer_data++;
    if (timer_data == 4294967280)
    {
      timer_data = 1;
    }
  }
  else
  {
    timer_data = 0;
  }
}

// Simplified Display for Single Anchor/Tag setup
void UWB_display()
{
  M5.dis.fillpix(UWB_MODE == 0 ? CRGB::Green : CRGB::Red);
}

void UWB_readString()
{
  switch (UWB_MODE)
  {
  case 0: // Tag mode
    if (Serial2.available())
    {
      delay(20);
      DATA = Serial2.readString(); // Đọc dữ liệu từ Serial2
      Serial.print("Tag Data: ");
      Serial.println(DATA); // Xuất dữ liệu ra Serial Monitor
      timer_flag = 0;
      timer_data = 1;
    }
    else
    {
      timer_flag = 1;
    }
    if (timer_data == 0 || timer_data > 8)
    { // Kiểm tra kết nối với tag
      if (timer_data == 9)
      {
        Serial.println("Lost connection with the tag!"); // Thông báo mất kết nối
      }
      DATA = "  0 2F   "; // Dữ liệu giả lập
      timer_flag = 0;
    }
    break;

  case 1: // Anchor mode
    if (timer_data == 0 || timer_data > 70)
    { // Kiểm tra kết nối với tag
      if (Serial2.available())
      {
        delay(2);
        DATA = Serial2.readString();           // Đọc dữ liệu từ Serial2
        Serial.println("Setup successfully!"); // Thông báo kết nối thành công
        timer_data = 1;
        timer_flag = 1;
        break;
      }
      else if (timer_data > 0 && Serial2.available() == 0)
      {
        Serial.println("Can't find the tag!!!"); // Thông báo không tìm thấy tag
        timer_flag = 0;
        break;
      }
    }
    break;
  }
}

void UWB_clear()
{
  if (Serial2.available())
  {
    delay(3);
    DATA = Serial2.readString();
  }
  DATA = "";
  timer_flag = 0;
  timer_data = 0;
  // M5.Lcd.fillRect(0, 50, 340, 150, BLACK);
}

// UWB Setup for Tag or Anchor
void UWB_setupmode()
{
  switch (UWB_MODE)
  {
  case 0: // Chế độ Tag
    for (int b = 0; b < 2; b++)
    { // Lặp lại hai lần để ổn định kết nối
      delay(50);
      Serial2.write("AT+anchor_tag=0\r\n"); // Thiết lập thiết bị làm Tag
      delay(50);
      Serial2.write("AT+interval=5\r\n"); // Đặt độ chính xác
      delay(50);
      Serial2.write("AT+switchdis=1\r\n"); // Bắt đầu đo khoảng cách
      delay(50);
      if (b == 0)
      {
        Serial2.write("AT+RST\r\n"); // Đặt lại thiết bị
      }
    }
    UWB_clear(); // Xóa dữ liệu
    break;

  case 1: // Chế độ Base Station
    for (int b = 0; b < 2; b++)
    {
      delay(50);
      Serial2.write("AT+anchor_tag=1,0"); // Thiết lập thiết bị làm Base Station
      // Serial2.print(UWB_B_NUMBER); // ID của Base Station
      Serial2.write("\r\n");
      delay(1);
      delay(50);
      if (b == 0)
      {
        Serial2.write("AT+RST\r\n"); // Đặt lại thiết bị
      }
    }
    UWB_clear(); // Xóa dữ liệu
    break;
  }
}

void UWB_Timer()
{
  timer = timerBegin(0, 80, true);
  timerAttachInterrupt(timer, Timer0_CallBack, true);
  timerAlarmWrite(timer, 1000000, true);
  timerAlarmEnable(timer);
}

void setup()
{
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
  Serial2.begin(115200, SERIAL_8N1, 16, 17);
  delay(100);
  Serial.println("UWB Setup Started");
  UWB_Timer();
  UWB_setupmode();
  UWB_display();
}

void loop()
{
  // Nothing to do here, FreeRTOS tasks handle the work
  M5.update();
  UWB_readString();
}