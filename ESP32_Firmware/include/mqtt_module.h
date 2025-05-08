#ifndef MQTT_MODULE_H
#define MQTT_MODULE_H

#include "../project_config.h"
#include "ArduinoJson.h"
#include "M5Atom.h"
#include "PubSubClient.h"
#include "WiFi.h"
#include "global_var.h"
#include "util.h"

void MQTT_setup();
void MQTT_processing();

#endif