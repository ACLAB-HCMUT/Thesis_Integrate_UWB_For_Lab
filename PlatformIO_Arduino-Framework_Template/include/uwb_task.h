#ifndef UWB_TASK_H
#define UWB_TASK_H

<<<<<<< Updated upstream:PlatformIO_Arduino-Framework_Template/include/uwb_task.h
#include <M5Stack.h>
#include "timer_task.h"
=======
// #include <M5Stack.h>
#include <M5Atom.h>
#include "timer_module.h"
>>>>>>> Stashed changes:PlatformIO_Arduino-Framework_Template/include/uwb_module.h

void UWB_display();
void UWB_clear();
void UWB_readString();
void UWB_setupmode();
void UWB_Timer();
void UWB_Keyscan();
void UWB_display();

#endif