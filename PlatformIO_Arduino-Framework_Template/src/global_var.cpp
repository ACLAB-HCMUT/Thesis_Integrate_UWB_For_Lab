#include "global_var.h"

const int LED_PIN = 13; // Set LED GPIO
String led_state;       // Stores LED state

const int ATOM_RX_PIN = 32; // Unit's pin TX connects to Atom's pin G32
const int ATOM_TX_PIN = 26; // Unit's pin RX connects to Atom's pin G26

String DATA = "";
String values[4] = {"2", "0", "0", "0"};