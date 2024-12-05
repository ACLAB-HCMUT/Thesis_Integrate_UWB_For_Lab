#include "file_manip.h"

void SPIFFS_setup() {
  bool success = SPIFFS.begin();
  if (success) {
    Serial.println("SPIFFS initialized");
  } else {
    Serial.println("SPIFFS mount failed");
  }
}