#ifndef MQTT_MODULE_H
#define MQTT_MODULE_H

#include "../project_config.h"
// #include "Adafruit_MQTT.h"
// #include "Adafruit_MQTT_Client.h"
#include "ArduinoJson.h"
#include "M5AtomS3.h"
#include "PubSubClient.h"
#include "WiFi.h"
#include "global_var.h"
#include "util.h"
#include "uwb_module.h"

// void MQTT_connect();
// void MQTT_send_data(Adafruit_MQTT_Publish topic, int id, float array[], String type);

// extern Adafruit_MQTT_Publish tagposition;
// extern Adafruit_MQTT_Publish anchorposition;
void MQTT_setup();
void MQTT_processing();

#endif