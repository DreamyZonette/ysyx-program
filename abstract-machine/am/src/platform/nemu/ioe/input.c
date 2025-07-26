#include <am.h>
#include <nemu.h>

#define KEYDOWN_MASK 0x8000
#define KEYCODE_MASK 0x7FFF

static uint32_t am_get_keycode (){
  uint32_t keycode = inl(KBD_ADDR);
  return keycode;
}

void __am_input_keybrd(AM_INPUT_KEYBRD_T *kbd) {
  uint32_t value = am_get_keycode();
  kbd->keydown = (value & KEYDOWN_MASK) != 0;
  kbd->keycode = value & KEYCODE_MASK;

  if (kbd->keycode == 0) {
    kbd->keycode = AM_KEY_NONE;
  }
  // kbd->keycode = AM_KEY_NONE;
}
