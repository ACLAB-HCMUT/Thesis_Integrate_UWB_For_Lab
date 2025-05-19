#ifndef WIFI_MODULE_H
#define WIFI_MODULE_H

#include "../project_config.h"
#include "WiFi.h"

void wifiTask(void *pvParameters);
void WIFI_setup();

#endif