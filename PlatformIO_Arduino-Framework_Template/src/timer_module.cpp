#include "timer_module.h"

hw_timer_t *timer = NULL;
int timer_flag = 0;
uint32_t timer_data = 0;

void IRAM_ATTR Timer0_CallBack(void) {
  if (timer_flag == 1) {
    timer_data++;
    if (timer_data == 4294967280) {
      timer_data = 1;
    }
  } else {
    timer_data = 0;
  }
}