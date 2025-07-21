#include <common.h>

static uint64_t get_time_internal() {

  struct timespec now;
  clock_gettime(CLOCK_MONOTONIC_COARSE, &now);
  uint64_t us = now.tv_sec * 1000000 + now.tv_nsec / 1000;
  return us;
}

void init_rand() {
  srand(get_time_internal());
}