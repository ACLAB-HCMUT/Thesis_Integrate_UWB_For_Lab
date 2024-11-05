#ifndef SERVER_MODULE_H
#define SERVER_MODULE_H

#include "ESPAsyncWebServer.h"
#include "SPIFFS.h"
#include "global_var.h"

void serverTask(void *pvParameters);

#endif