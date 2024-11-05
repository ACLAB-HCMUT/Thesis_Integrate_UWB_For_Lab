#ifndef TIMER_TASK_H
#define TIMER_TASK_H

// #include <M5Stack.h>
#include <M5Atom.h>

extern hw_timer_t *timer;
extern int timer_flag;
extern uint32_t timer_data;

void IRAM_ATTR Timer0_CallBack(void);

#endif