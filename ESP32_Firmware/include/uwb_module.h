#ifndef UWB_MODULE_H
#define UWB_MODULE_H

// #include "M5Atom.h"
#include "M5AtomS3.h"
#include "global_var.h"
#include "timer_module.h"

void UWB_clear();
void UWB_setupmode();
void UWB_timer();
void UWB_readString();
void UWB_display();
void printTimeStamp();

#endif