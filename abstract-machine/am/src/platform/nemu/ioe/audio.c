#include <am.h>
#include <nemu.h>
#include <stdio.h>

#define AUDIO_FREQ_ADDR      (AUDIO_ADDR + 0x00)
#define AUDIO_CHANNELS_ADDR  (AUDIO_ADDR + 0x04)
#define AUDIO_SAMPLES_ADDR   (AUDIO_ADDR + 0x08)
#define AUDIO_SBUF_SIZE_ADDR (AUDIO_ADDR + 0x0c)
#define AUDIO_INIT_ADDR      (AUDIO_ADDR + 0x10)
#define AUDIO_COUNT_ADDR     (AUDIO_ADDR + 0x14)

#define AUDIO_BUF_SIZE 0x10000

static uint32_t audio_freq = 44100;
static uint32_t audio_channels = 2;
static uint32_t audio_samples = 1024;
static uint32_t audio_sbuf_size = AUDIO_BUF_SIZE;
static int audio_count = 0; 



void __am_audio_init() {
  outl(AUDIO_INIT_ADDR, 1);

  audio_freq = inl(AUDIO_FREQ_ADDR);
  audio_channels = inl(AUDIO_CHANNELS_ADDR);
  audio_samples = inl(AUDIO_SAMPLES_ADDR);
  audio_sbuf_size = inl(AUDIO_SBUF_SIZE_ADDR);

  if (audio_sbuf_size > AUDIO_BUF_SIZE) {
    audio_sbuf_size = AUDIO_BUF_SIZE;
  }
  audio_count = 0;

}

void __am_audio_config(AM_AUDIO_CONFIG_T *cfg) {
  cfg->present = true;
  if(cfg->bufsize == 0)
  cfg->bufsize = audio_sbuf_size;
}

void __am_audio_ctrl(AM_AUDIO_CTRL_T *ctrl) {
  if (ctrl->freq != 0) {
    outl(AUDIO_FREQ_ADDR, ctrl->freq);
    audio_freq = ctrl->freq;
  }
  if (ctrl->channels != 0) {
    outl(AUDIO_CHANNELS_ADDR, ctrl->channels);
    audio_channels = ctrl->channels;
  }
  if (ctrl->samples != 0) {
    outl(AUDIO_SAMPLES_ADDR, ctrl->samples);
    audio_samples = ctrl->samples;
  }
  ctrl->freq = audio_freq;
  ctrl->channels = audio_channels;
  ctrl->samples = audio_samples;
}

void __am_audio_status(AM_AUDIO_STATUS_T *stat) {
  audio_count = inl(AUDIO_COUNT_ADDR);
  stat->count = audio_count;
  printf("audio count: %d\n", audio_count);
}

void __am_audio_play(AM_AUDIO_PLAY_T *ctl) {
  Area *area = &ctl->buf;
  uint8_t *src = (uint8_t *)area->start;
  uint32_t len = (uint8_t *)area->end - src;
  if (len == 0) {
        // 没有数据可播放
        ctl->buf.start = NULL;
        ctl->buf.end = NULL;
        // printf("11");
        return;
    }
    //uintptr_t hw_buf = AUDIO_SBUF_ADDR;
    uint8_t *hw_buf = (uint8_t *)(uintptr_t)AUDIO_SBUF_ADDR;
    for (uint32_t i = 0; i < len; i++) {
      //outb(hw_buf + i, src[i]);
      hw_buf[i] = src[i];
    }
    audio_count -= len;
    outl(AUDIO_COUNT_ADDR, audio_count);

    ctl->buf.start = (void *)hw_buf;
    ctl->buf.end = (void *)(hw_buf + len);
}
