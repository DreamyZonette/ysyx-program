#include <am.h>
#include <nemu.h>
#include <klib.h>

static uint64_t last_counter = 0;

void __am_timer_init() {
}

void __am_timer_uptime(AM_TIMER_UPTIME_T *uptime) {
  uint64_t counter = cpu_count();
  uint64_t diff = 0;
  if (counter < last_counter) {
    // overflow
    counter += 0x100000000;
  }
  uptime->us = (counter - last_counter) * 1000000 / cpu_count();
  if(last_counter != counter) diff = 1;
  last_counter = counter;
  if(diff == 1){

  printf("%d\n", uptime->us);
  }
}

void __am_timer_rtc(AM_TIMER_RTC_T *rtc) {
  rtc->second = 0;
  rtc->minute = 0;
  rtc->hour   = 0;
  rtc->day    = 0;
  rtc->month  = 0;
  rtc->year   = 1900;
}
