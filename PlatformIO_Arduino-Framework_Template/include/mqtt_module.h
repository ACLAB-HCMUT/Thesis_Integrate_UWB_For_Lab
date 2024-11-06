#ifndef MQTT_MODULE_H
#define MQTT_MODULE_H

#include "WiFi.h"
#include "Adafruit_MQTT.h"
#include "Adafruit_MQTT_Client.h"
#include "../project_config.h"

void MQTT_connect();
void MQTT_send_data();

#endif