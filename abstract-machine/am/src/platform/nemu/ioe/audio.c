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
static uint32_t audio_sbuf_size = 0;
static int audio_count = 0; 
//static int audio_write_ptr = 0; 



void __am_audio_init() {
  outl(AUDIO_INIT_ADDR, 1);

  // audio_freq = inl(AUDIO_FREQ_ADDR);
  // audio_channels = inl(AUDIO_CHANNELS_ADDR);
  // audio_samples = inl(AUDIO_SAMPLES_ADDR);
  //audio_sbuf_size = inl(AUDIO_SBUF_SIZE_ADDR);
  //printf("%d\n", audio_sbuf_size);

  // if (audio_sbuf_size > AUDIO_BUF_SIZE) {
  //   audio_sbuf_size = AUDIO_BUF_SIZE;
  // }
  //printf("%d\n", audio_sbuf_size);

}

void __am_audio_config(AM_AUDIO_CONFIG_T *cfg) {
  cfg->present = true;
  outl(AUDIO_SBUF_SIZE_ADDR, cfg->bufsize);
  audio_sbuf_size = cfg->bufsize;
  printf("%d\n", cfg->bufsize);
  // if(cfg->bufsize == 0)
  // cfg->bufsize = audio_sbuf_size;
}

void __am_audio_ctrl(AM_AUDIO_CTRL_T *ctrl) {
  if (ctrl->freq == 0) {
    outl(AUDIO_FREQ_ADDR, ctrl->freq);
    audio_freq = ctrl->freq;
  }
  if (ctrl->channels == 0) {
    outl(AUDIO_CHANNELS_ADDR, ctrl->channels);
    audio_channels = ctrl->channels;
  }
  if (ctrl->samples == 0) {
    outl(AUDIO_SAMPLES_ADDR, ctrl->samples);
    audio_samples = ctrl->samples;
  }
  // ctrl->freq = audio_freq;
  // ctrl->channels = audio_channels;
  // ctrl->samples = audio_samples;
  
}

void __am_audio_status(AM_AUDIO_STATUS_T *stat) {
  audio_count = stat->count;
  //printf("%d\n", audio_count);
  //outl(AUDIO_COUNT_ADDR, audio_count);
}

void __am_audio_play(AM_AUDIO_PLAY_T *ctl) {
  Area *area = &ctl->buf;
    uint8_t *src = (uint8_t *)area->start;
    uint32_t len = (uint8_t *)area->end - src;
    
    if (len == 0) {
        // 没有数据可播放
        ctl->buf.start = NULL;
        ctl->buf.end = NULL;
        return;
    }
    
    // 获取当前缓冲区使用情况
    uint32_t used = inl(AUDIO_COUNT_ADDR);
    uint32_t free_space = audio_sbuf_size - used;
    
    // 阻塞等待直到有足够空间
    while (free_space < len) {
        // 等待一段时间后重新检查
        //usleep(1000); // 1ms延迟，避免忙等待
        for (volatile int i = 0; i < 1000; i++);

        used = inl(AUDIO_COUNT_ADDR);
        free_space = audio_sbuf_size - used;
    }
    
    // 计算写入位置（环形缓冲区）
    uint32_t write_ptr = used % audio_sbuf_size;
    
    // 计算第一段长度（从写入位置到缓冲区末尾）
    uint32_t first_chunk = audio_sbuf_size - write_ptr;
    if (first_chunk > len) {
        first_chunk = len;
    }
    
    uint8_t *hw_buf = (uint8_t *)(uintptr_t)AUDIO_SBUF_ADDR;

    // 手动复制第一段数据
    for (uint32_t i = 0; i < first_chunk; i++) {
        hw_buf[write_ptr + i] = src[i];
    }
    
    // 复制第二段数据（如果需要）
    if (len > first_chunk) {
        uint32_t second_chunk = len - first_chunk;
        for (uint32_t i = 0; i < second_chunk; i++) {
            hw_buf[i] = src[first_chunk + i];
        }
    }
    
    // 更新已使用空间计数
    uint32_t new_used = used + len;
    outl(AUDIO_COUNT_ADDR, new_used);
    
    // 设置返回区域
    ctl->buf.start = (void *)(hw_buf + write_ptr);
    ctl->buf.end = (void *)(hw_buf + write_ptr + len);
  // //audio_count = inl(AUDIO_COUNT_ADDR);
  // printf("%d\n", audio_count);
  // Area *area = &ctl->buf;
  // uint8_t *src = (uint8_t *)area->start;
  // uint32_t len = (uint8_t *)area->end - src;
  // if (len == 0) {
  //   // 没有数据可播放
  //   ctl->buf.start = NULL;
  //   ctl->buf.end = NULL;
  //   return;
  // }
  // if (len > audio_sbuf_size) {
  //   len = audio_sbuf_size;
  // }

  // uint8_t *hw_buf = (uint8_t *)(uintptr_t)AUDIO_SBUF_ADDR;
  // for (uint32_t i = 0; i < len; i++) {
  //   hw_buf[audio_write_ptr++] = *src++;
  //   if(audio_write_ptr >= audio_sbuf_size) {
  //     audio_write_ptr = 0;
  //   }
  // }
  // audio_count += len;
  // outl(AUDIO_COUNT_ADDR, audio_count);

  // ctl->buf.start = (void *)hw_buf;
  // ctl->buf.end = (void *)(hw_buf + len);
}
