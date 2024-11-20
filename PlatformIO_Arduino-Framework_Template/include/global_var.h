#ifndef GLOBAL_VAR_H
#define GLOBAL_VAR_H

#include "M5Atom.h"

struct Point {
  float x, y, z;
};

// Global variables for LED
extern const int LED_PIN;
extern String led_state;

// Global variables for UART
extern const int ATOM_RX_PIN;
extern const int ATOM_TX_PIN;

// Gobal variables for UWB
extern String data_uwb;
extern float distance_uwb[];
extern float position_uwb[];
extern Point anchor_1;
extern Point anchor_2;
extern Point anchor_3;
extern Point anchor_4;

// Configuration for MQTT connection
extern const int MQTT_RETRIES;
extern const int MQTT_WAIT_RETRY;
extern const int MQTT_WAIT_SEND;

#endif