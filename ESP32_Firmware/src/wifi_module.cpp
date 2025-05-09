#include "wifi_module.h"
#include "../project_config.h"

// Replace with your network credentials
const char *ssid = PROJECT_WIFI_SSID;
const char *password = PROJECT_WIFI_PASSWORD;

// Task to handle Wi-Fi connection
void wifiTask(void *pvParameters) {
  Serial.begin(115200);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    vTaskDelay(1000 / portTICK_PERIOD_MS);
    Serial.println("Connecting to WiFi..");
  }

  // Print ESP32 Local IP Address
  Serial.println(WiFi.localIP());
  vTaskDelete(NULL); // Delete the task when done
}

void WIFI_setup() {
  WiFi.begin(WLAN_SSID, WLAN_PASS);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print("Connecting to WiFi..");
  }

  Serial.println();
  Serial.println("WiFi connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
}