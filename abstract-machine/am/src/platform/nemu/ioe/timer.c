#include <am.h>
#include <nemu.h>
#include <klib.h>

void __am_timer_init() {
}

void __am_timer_uptime(AM_TIMER_UPTIME_T *uptime) {
  uptime->us = 0;
  int year, month, day, hour, minute, second;
  year = inl(RTC_ADDR);
  month = inl(RTC_ADDR + 4);
  day = inl(RTC_ADDR + 8);
  hour = inl(RTC_ADDR + 12);
  minute = inl(RTC_ADDR + 16);
  second = inl(RTC_ADDR + 20);
  printf("%d年%d月%d日%d时%d分%d秒\n", year, month, day, hour, minute, second);
}

void __am_timer_rtc(AM_TIMER_RTC_T *rtc) {
  rtc->second = 0;
  rtc->minute = 0;
  rtc->hour   = 0;
  rtc->day    = 0;
  rtc->month  = 0;
  rtc->year   = 1900;
}
