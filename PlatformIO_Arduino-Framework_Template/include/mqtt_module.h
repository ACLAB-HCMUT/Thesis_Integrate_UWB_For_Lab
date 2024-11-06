#ifndef MQTT_MODULE_H
#define MQTT_MODULE_H

#include "../project_config.h"
#include "Adafruit_MQTT.h"
#include "Adafruit_MQTT_Client.h"
#include "WiFi.h"
#include "global_var.h"
#include "util.h"

void MQTT_connect();
void MQTT_send_data();

#endif