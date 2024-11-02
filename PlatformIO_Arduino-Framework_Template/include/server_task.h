#ifndef SERVER_TASK_H
#define SERVER_TASK_H

#include "ESPAsyncWebServer.h"
#include "SPIFFS.h"
#include "global_variable.h"

void serverTask(void *pvParameters);

#endif