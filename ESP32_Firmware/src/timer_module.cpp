#include "timer_module.h"

hw_timer_t *timer = NULL;
int timer_flag = 0;
uint32_t timer_data = 0;

// Configure Vietnam time zone
const long gmt_offset_sec = 7 * 3600; // UTC+7
const int daylight_offset_sec = 0;    // Không áp dụng giờ mùa hè

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

void NPT_setup() {
  configTime(gmt_offset_sec, daylight_offset_sec, "pool.ntp.org");

  // Wait for time
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    Serial.println("Can't get the time!");
    return;
  }
}

void print_time_stamp() {
  struct tm timeinfo;
  if (getLocalTime(&timeinfo)) {
    Serial.printf("[%04d-%02d-%02d %02d:%02d:%02d] ",
                  timeinfo.tm_year + 1900, timeinfo.tm_mon + 1, timeinfo.tm_mday,
                  timeinfo.tm_hour, timeinfo.tm_min, timeinfo.tm_sec);
  } else {
    Serial.print("[Time unknown] ");
  }
}