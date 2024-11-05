#include "global_var.h"

const int LED_PIN = 13; // Set LED GPIO
String led_state; // Stores LED state

const int ATOM_RX1_PIN = 32; // Unit's pin TX connects to Atom's pin G32
const int ATOM_TX1_PIN = 26; // Unit's pin RX connects to Atom's pin G26
const int ATOM_RX2_PIN = 21; // BU01's pin TX connects to Atom's pin G21
const int ATOM_TX2_PIN = 25; // BU01's pin RX connects to Atom's pin G25