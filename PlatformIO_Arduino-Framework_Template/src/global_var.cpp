#include "global_var.h"

const int LED_PIN = 13; // Set LED GPIO
String led_state;       // Stores LED state

const int ATOM_RX_PIN = 32;                                     // Unit's pin TX connects to Atom's pin G32
const int ATOM_TX_PIN = 26;                                     // Unit's pin RX connects to Atom's pin G26
String data_uwb = "an1:1.34m\nan2:1.35m\nan3:1.36m\nan4:1.37m"; // Raw UWB distance data received
float value_uwb[4] = {1, 0, 0, 0};                              // Stores the distance to each anchor

const int MQTT_RETRIES = 3;       // Maximum number of retry
const int MQTT_WAIT_RETRY = 5000; // Wait time (in milliseconds) between each retry
const int MQTT_WAIT_SEND = 6000;  // Wait time (in milliseconds) between each data transmission to MQTT