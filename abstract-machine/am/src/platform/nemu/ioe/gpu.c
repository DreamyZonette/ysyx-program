#include <am.h>
#include <nemu.h>


#define SYNC_ADDR (VGACTL_ADDR + 4)

//static uint32_t size = 0;
static uint32_t width = 0;
static uint32_t height = 0;

static void am_get_gpu_config() {
    uint32_t config = inl(VGACTL_ADDR);
    width = config >> 16;
    height = config & 0xFFFF;
}

void __am_gpu_init() {
  am_get_gpu_config();

  int i;
  int w = 32;  // TODO: get the correct width
  int h = 32;  // TODO: get the correct height
  uint32_t *fb = (uint32_t *)(uintptr_t)FB_ADDR;
  for (i = 0; i < w * h; i ++) fb[i] = i;
  outl(SYNC_ADDR, 1);
}

void __am_gpu_config(AM_GPU_CONFIG_T *cfg) {
  if (width == 0 || height == 0) {
    //am_get_gpu_config();
  }
  
  *cfg = (AM_GPU_CONFIG_T) {
    .present = true, .has_accel = false,
    .width = 32, .height = 32,
    .vmemsz = 32 * 32 * sizeof(uint32_t)
  };
}

void __am_gpu_fbdraw(AM_GPU_FBDRAW_T *ctl) {
  if (ctl->sync) {
    outl(SYNC_ADDR, 1);
  }
}

void __am_gpu_status(AM_GPU_STATUS_T *status) {
  status->ready = true;
}
