#include <am.h>
#include <nemu.h>
#include <stdio.h>


#define KEYDOWN_MASK 0x8000
#define KEYCODE_MASK 0x7FFF

static uint32_t raw_keycode_to_am_key(uint32_t raw_code) {
    // 基于PS/2键盘扫描码的映射
    switch (raw_code) {
        case 0x01: return AM_KEY_ESCAPE;
        case 0x02: return AM_KEY_1;
        case 0x03: return AM_KEY_2;
        case 0x04: return AM_KEY_3;
        case 0x05: return AM_KEY_4;
        case 0x06: return AM_KEY_5;
        case 0x07: return AM_KEY_6;
        case 0x08: return AM_KEY_7;
        case 0x09: return AM_KEY_8;
        case 0x0A: return AM_KEY_9;
        case 0x0B: return AM_KEY_0;
        case 0x0C: return AM_KEY_MINUS;
        case 0x0D: return AM_KEY_EQUALS;
        case 0x0E: return AM_KEY_BACKSPACE;
        case 0x0F: return AM_KEY_TAB;
        case 0x10: return AM_KEY_Q;
        case 0x11: return AM_KEY_W;
        case 0x12: return AM_KEY_E;
        case 0x13: return AM_KEY_R;
        case 0x14: return AM_KEY_T;
        case 0x15: return AM_KEY_Y;
        case 0x16: return AM_KEY_U;
        case 0x17: return AM_KEY_I;
        case 0x18: return AM_KEY_O;
        case 0x19: return AM_KEY_P;
        case 0x1A: return AM_KEY_LEFTBRACKET;
        case 0x1B: return AM_KEY_RIGHTBRACKET;
        case 0x1C: return AM_KEY_RETURN;
        case 0x1E: return AM_KEY_A;
        case 0x1F: return AM_KEY_S;
        case 0x20: return AM_KEY_D;
        case 0x21: return AM_KEY_F;
        case 0x22: return AM_KEY_G;
        case 0x23: return AM_KEY_H;
        case 0x24: return AM_KEY_J;
        case 0x25: return AM_KEY_K;
        case 0x26: return AM_KEY_L;
        case 0x27: return AM_KEY_SEMICOLON;
        case 0x28: return AM_KEY_APOSTROPHE;
        case 0x29: return AM_KEY_GRAVE;
        case 0x2B: return AM_KEY_BACKSLASH;
        case 0x2C: return AM_KEY_Z;
        case 0x2D: return AM_KEY_X;
        case 0x2E: return AM_KEY_C;
        case 0x2F: return AM_KEY_V;
        case 0x30: return AM_KEY_B;
        case 0x31: return AM_KEY_N;
        case 0x32: return AM_KEY_M;
        case 0x33: return AM_KEY_COMMA;
        case 0x34: return AM_KEY_PERIOD;
        case 0x35: return AM_KEY_SLASH;
        case 0x39: return AM_KEY_SPACE;
        case 0x3B: return AM_KEY_F1;
        case 0x3C: return AM_KEY_F2;
        case 0x3D: return AM_KEY_F3;
        case 0x3E: return AM_KEY_F4;
        case 0x3F: return AM_KEY_F5;
        case 0x40: return AM_KEY_F6;
        case 0x41: return AM_KEY_F7;
        case 0x42: return AM_KEY_F8;
        case 0x43: return AM_KEY_F9;
        case 0x44: return AM_KEY_F10;
        case 0x57: return AM_KEY_F11;
        case 0x58: return AM_KEY_F12;
        case 0x48: return AM_KEY_UP;
        case 0x50: return AM_KEY_DOWN;
        case 0x4B: return AM_KEY_LEFT;
        case 0x4D: return AM_KEY_RIGHT;
        case 0x52: return AM_KEY_INSERT;
        case 0x53: return AM_KEY_DELETE;
        case 0x47: return AM_KEY_HOME;
        case 0x4F: return AM_KEY_END;
        case 0x49: return AM_KEY_PAGEUP;
        case 0x51: return AM_KEY_PAGEDOWN;
        default: return AM_KEY_NONE;
    }
}


static uint32_t am_get_keycode (){
  uint32_t keycode = inl(KBD_ADDR);
  return keycode;
}

void __am_input_keybrd(AM_INPUT_KEYBRD_T *kbd) {
  uint32_t value = am_get_keycode();
  uint32_t raw_code = value & KEYCODE_MASK;
  if(raw_code != 0) printf("raw_code: %d\n", raw_code);

  kbd->keydown = (value & KEYDOWN_MASK) != 0;
  kbd->keycode = raw_keycode_to_am_key(raw_code);

  if (kbd->keycode == 0) {
    kbd->keycode = AM_KEY_NONE;
  }
}
