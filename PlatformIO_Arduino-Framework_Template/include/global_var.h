#ifndef GLOBAL_VAR_H
#define GLOBAL_VAR_H

#include "M5Atom.h"

// Global variables for LED
extern const int LED_PIN;
extern String led_state;

// Global variables for UART
extern const int ATOM_RX_PIN;
extern const int ATOM_TX_PIN;
extern String data_uwb;
extern float value_uwb[];
extern float distance[4];
extern float position[4];

// Configuration for MQTT connection
extern const int MQTT_RETRIES;
extern const int MQTT_WAIT_RETRY;
extern const int MQTT_WAIT_SEND;

#endif