#ifndef TIMER_MODULE_H
#define TIMER_MODULE_H

// #include "M5Atom.h"
#include "M5AtomS3.h"

extern hw_timer_t *timer;
extern int timer_flag;
extern uint32_t timer_data;

void IRAM_ATTR Timer0_CallBack(void);

#endif