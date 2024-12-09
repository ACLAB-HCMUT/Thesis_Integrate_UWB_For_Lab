#ifndef GLOBAL_VAR_H
#define GLOBAL_VAR_H

#include "M5Atom.h"

#define N_ANCHORS 4

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
extern float slope;
extern float intercept;
// extern float anchor_f1[];
// extern float anchor_f2[];
// extern float anchor_f3[];
// extern float anchor_f4[];

extern float anchor_matrix[N_ANCHORS][3];
extern float current_distance_rmse;

// Configuration for MQTT connection
extern const int MQTT_RETRIES;
extern const int MQTT_WAIT_RETRY;
extern const int MQTT_WAIT_SEND;

#endif