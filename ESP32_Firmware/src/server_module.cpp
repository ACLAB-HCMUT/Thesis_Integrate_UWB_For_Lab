/*
#include "server_module.h"

// Create AsyncWebServer object on port 80
AsyncWebServer server(80);

// Replaces placeholder with LED state value
String processor(const String &var) {
  Serial.println(var);
  if (var == "STATE") {
    if (digitalRead(g_LED_PIN)) {
      g_led_state = "ON";
    } else {
      g_led_state = "OFF";
    }
    Serial.print(g_led_state);
    return g_led_state;
  }
  return String();
}

// Task to handle server
void serverTask(void *pvParameters) {
  // Initialize SPIFFS
  if (!SPIFFS.begin(true)) {
    Serial.println("An Error has occurred while mounting SPIFFS");
    vTaskDelete(NULL); // Delete the task if SPIFFS initialization fails
  }

  // Route for root / web page
  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request) {
    request->send(SPIFFS, "/index.html", String(), false, processor);
  });

  // Route to load style.css file
  server.on("/style.css", HTTP_GET, [](AsyncWebServerRequest *request) {
    request->send(SPIFFS, "/style.css", "text/css");
  });

  // Route to set GPIO to HIGH
  server.on("/on", HTTP_GET, [](AsyncWebServerRequest *request) {
    digitalWrite(g_LED_PIN, HIGH);
    request->send(SPIFFS, "/index.html", String(), false, processor);
  });

  // Route to set GPIO to LOW
  server.on("/off", HTTP_GET, [](AsyncWebServerRequest *request) {
    digitalWrite(g_LED_PIN, LOW);
    request->send(SPIFFS, "/index.html", String(), false, processor);
  });

  // Start server
  server.begin();
  vTaskDelete(NULL); // Delete the task when done
}
  */