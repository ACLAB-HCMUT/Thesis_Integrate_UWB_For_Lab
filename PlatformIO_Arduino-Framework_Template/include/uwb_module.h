#ifndef UWB_MODULE_H
#define UWB_MODULE_H

#include "ArduinoEigen.h"
#include "M5Atom.h"
#include "global_var.h"
#include "timer_module.h"

void UWB_clear();
void UWB_setupmode();
void UWB_timer();
void UWB_readString();
void UWB_display();
void parse_data(String data);
void calc_position();

#endif