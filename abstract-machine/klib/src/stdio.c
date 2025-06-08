#include <am.h>
#include <klib.h>
#include <klib-macros.h>
#include <stdarg.h>

#if !defined(__ISA_NATIVE__) || defined(__NATIVE_USE_KLIB__)

void reverse(char *str, int len);
void itoa(int num, char *str);

int printf(const char *fmt, ...) {
  va_list args;
  va_start(args, fmt);
  int count = 0;

  const char *p = fmt;
  while(*p != '\0')
  {
    if(*p != '%')
    {
      putch(*p);
      p ++;
      count ++;
    }
    else
    {
      p++;
      switch(*p)
      {
        case 'd':
        {
          int num = va_arg(args, int);
          char str[20];
          itoa(num, str);
          for(int i = 0; str[i] != '\0'; i++)
          {
            putch(str[i]);
            count ++;
          }
          p ++;
          break;
        }
        case 's':
        {
          char *str = va_arg(args, char *);
          for(int i = 0; str[i] != '\0'; i++)
          {
            putch(str[i]);
            count ++;
          }
          p ++;
          break;
        }
      }
      
    }
  }
  va_end(args);
  return count;
  // panic("Not implemented");
}

int vsprintf(char *out, const char *fmt, va_list ap) {
  panic("Not implemented");
}

int sprintf(char *out, const char *fmt, ...) {
  va_list args;
  va_start(args, fmt);
  char *p = out;
  while(*fmt != '\0')
  {
    if(*fmt != '%')
    {
      *p++ = *fmt++;
    }
    else
    {
      fmt++;
      switch(*fmt)
      {
        case 'd':
        {
          int num = va_arg(args, int);
          char str[20];
          itoa(num, str);
          for(int i = 0; str[i] != '\0'; i++)
          {
            *p++ = str[i];
          }
          break;
        }
        case 's':
        {
          char *str = va_arg(args, char *);
          for(int i = 0; str[i] != '\0'; i++)
          {
            *p++ = str[i];
          }
          break;
        }
      }
      fmt++;
    }
  }
  *p = '\0';
  va_end(args);
  return p - out;
  // panic("Not implemented");
}

int snprintf(char *out, size_t n, const char *fmt, ...) {
  panic("Not implemented");
}

int vsnprintf(char *out, size_t n, const char *fmt, va_list ap) {
  panic("Not implemented");
}

void reverse(char *str, int len) { 
  int start = 0;
  int end = len - 1;
  while (start < end) {
    char temp = str[start];
    str[start] = str[end];
    str[end] = temp;
    start++;
    end--;
  }
}

void itoa(int num, char *str)
{
  size_t i = 0;
  bool isNegative = false;
  if(num == 0) {
    str[i++] = '0';
    str[i] = '\0';
    return;
  }
  if(num < 0){
    isNegative = true;
    num = -num;
  }
  while(num > 0 ){
    str[i++] = (num % 10) + '0';
    num = num / 10;
  }
  if(isNegative)
    str[i++] = '-';
  str[i] = '\0';
  reverse(str, i);
}

#endif
