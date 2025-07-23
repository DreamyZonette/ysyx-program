#ifndef __MACRO_H__
#define __MACRO_H__

#define PG_ALIGN __attribute((aligned(4096)))
#define ARRLEN(arr) (int)(sizeof(arr) / sizeof(arr[0]))

#endif