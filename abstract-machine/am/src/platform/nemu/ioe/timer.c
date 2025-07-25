#include <am.h>
#include <nemu.h>
//#include <klib.h>

static uint64_t last_counter = 0;

static uint64_t am_get_time() {
  uint32_t hi, lo;
  hi = inl(RTC_ADDR);
  lo = inl(RTC_ADDR + 4);
  return ((uint64_t)hi << 32) | lo;
}


void __am_timer_init() {
}

void __am_timer_uptime(AM_TIMER_UPTIME_T *uptime) {
  uint64_t now = am_get_time();
  uint64_t diff = (now - last_counter) / 1000000;
  last_counter = now;

  uptime->us += diff;
  
}

void __am_timer_rtc(AM_TIMER_RTC_T *rtc) {
  rtc->second = 0;
  rtc->minute = 0;
  rtc->hour   = 0;
  rtc->day    = 0;
  rtc->month  = 0;
  rtc->year   = 1900;
}
