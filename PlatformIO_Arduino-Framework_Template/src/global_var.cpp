#include "global_var.h"

const int LED_PIN = 13; // Set LED GPIO
String led_state;       // Stores LED state

const int ATOM_RX_PIN = 32; // Unit's pin TX connects to Atom's pin G32
const int ATOM_TX_PIN = 26; // Unit's pin RX connects to Atom's pin G26

String data_uwb = "an1:1.98m\nan2:1.71m\nan3:2.54m\nan4:2.82m"; // Raw UWB distance data received
float distance_uwb[4] = {1, 0, 0, 0};                           // Stores the distance to each anchor
float position_uwb[3] = {0, 0, 0};                              // Stores position of tag
float slope = 1.1338989898989882;
float intercept = 0.117644444444446;
Point anchor_1 = {0.0f, 0.0f, 2.5f};
Point anchor_2 = {2.5f, 2.5f, 2.5f};
Point anchor_3 = {0.0f, 2.5f, 0.0f};
Point anchor_4 = {2.5f, 0.0f, 0.0f};

const int MQTT_RETRIES = 3;       // Maximum number of retry
const int MQTT_WAIT_RETRY = 5000; // Wait time (in milliseconds) between each retry
const int MQTT_WAIT_SEND = 6000;  // Wait time (in milliseconds) between each data transmission to MQTT