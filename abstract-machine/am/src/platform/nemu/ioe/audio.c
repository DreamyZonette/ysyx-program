#include <am.h>
#include <nemu.h>

#define AUDIO_FREQ_ADDR      (AUDIO_ADDR + 0x00)
#define AUDIO_CHANNELS_ADDR  (AUDIO_ADDR + 0x04)
#define AUDIO_SAMPLES_ADDR   (AUDIO_ADDR + 0x08)
#define AUDIO_SBUF_SIZE_ADDR (AUDIO_ADDR + 0x0c)
#define AUDIO_INIT_ADDR      (AUDIO_ADDR + 0x10)
#define AUDIO_COUNT_ADDR     (AUDIO_ADDR + 0x14)

#define AUDIO_BUF_SIZE 4096

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

}

void __am_audio_config(AM_AUDIO_CONFIG_T *cfg) {
  cfg->present = true;
  if(cfg->bufsize == 0)
  cfg->bufsize = audio_sbuf_size;
}

void __am_audio_ctrl(AM_AUDIO_CTRL_T *ctrl) {
  ctrl->freq = audio_freq;
  ctrl->channels = audio_channels;
  ctrl->samples = audio_samples;
}

void __am_audio_status(AM_AUDIO_STATUS_T *stat) {
  audio_count = inl(AUDIO_COUNT_ADDR);
  stat->count = audio_count;
}

void __am_audio_play(AM_AUDIO_PLAY_T *ctl) {
  audio_count = inl(AUDIO_COUNT_ADDR);
  ctl->buf.start = (void *)(AUDIO_SBUF_ADDR);
  ctl->buf.end = (void *)(AUDIO_SBUF_ADDR + audio_count);
}
