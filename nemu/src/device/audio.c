/***************************************************************************************
* Copyright (c) 2014-2024 Zihao Yu, Nanjing University
*
* NEMU is licensed under Mulan PSL v2.
* You can use this software according to the terms and conditions of the Mulan PSL v2.
* You may obtain a copy of Mulan PSL v2 at:
*          http://license.coscl.org.cn/MulanPSL2
*
* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
* EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
* MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
*
* See the Mulan PSL v2 for more details.
***************************************************************************************/

#include <common.h>
#include <device/map.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_audio.h>

enum {
  reg_freq,
  reg_channels,
  reg_samples,
  reg_sbuf_size,
  reg_init,
  reg_count,
  nr_reg
};
//参考
// typedef struct SDL_AudioSpec
// {
//     int freq;                   /**< DSP frequency -- samples per second */
//     SDL_AudioFormat format;     /**< Audio data format */
//     Uint8 channels;             /**< Number of channels: 1 mono, 2 stereo */
//     Uint8 silence;              /**< Audio buffer silence value (calculated) */
//     Uint16 samples;             /**< Audio buffer size in sample FRAMES (total samples divided by channel count) */
//     Uint16 padding;             /**< Necessary for some compile environments */
//     Uint32 size;                /**< Audio buffer size in bytes (calculated) */
//     SDL_AudioCallback callback; /**< Callback that feeds the audio device (NULL to use SDL_QueueAudio()). */
//     void *userdata;             /**< Userdata passed to callback (ignored for NULL callbacks). */
// } SDL_AudioSpec;


// SDL_AudioSpec s = {};
// s.format = AUDIO_S16SYS;  // 假设系统中音频数据的格式总是使用16位有符号数来表示
// s.channels = 2;          // 假设系统中音频数据总是双声道
// s.freq = 44100;          // 假设系统中音频数据的采样率为44.1kHz
// s.samples = 1024;        // 假设系统中音频数据缓冲区的大小为1024个采样点
// s.size = s.samples * 2 * 2;  // 计算音频数据缓冲区的大小
// s.silence = 0;           // 计算静音值
// s.userdata = NULL;        // 不使用
// s.callback = NULL;        // 不使用

// SDL_InitSubSystem(SDL_INIT_AUDIO);
// SDL_OpenAudio(&s, NULL);
// SDL_PauseAudio(0);
static SDL_AudioDeviceID dev = 0;
static uint32_t rp = 0;  // 环形缓冲区读取位置
static uint32_t wp = 0;  // 环形缓冲区写入位置

static uint8_t *sbuf = NULL;
static uint32_t *audio_base = NULL;

static void audio_io_handler(uint32_t offset, int len, bool is_write) {
   if (offset % 4 != 0 || len != 4) return;
  int index = offset / 4;

  if (is_write) {
    if (index == reg_init && dev == 0) {
      // 初始化音频设备
      SDL_AudioSpec want, have;
      want.freq = audio_base[reg_freq];
      want.format = AUDIO_S16SYS;
      want.channels = audio_base[reg_channels];
      want.samples = audio_base[reg_samples];
      want.callback = NULL;

      dev = SDL_OpenAudioDevice(NULL, 0, &want, &have, 0);
      if (dev) SDL_PauseAudioDevice(dev, 0);
      else Log("Audio init failed: %s", SDL_GetError());
    } 
    else if (index == reg_count && dev) {
      // 提交音频数据 (val = 要提交的字节数)
      uint32_t len_val = audio_base[reg_count];
      // uint32_t queued = 0;
      
      // 计算可提交数据量 (考虑环形缓冲区)
      uint32_t remain = (wp >= rp) ? (wp - rp) : (CONFIG_SB_SIZE - rp + wp);
      len_val = (len_val > remain) ? remain : len_val;
      
      if (len_val > 0) {
        // 处理非连续内存提交
        if (rp + len_val <= CONFIG_SB_SIZE) {
          SDL_QueueAudio(dev, &sbuf[rp], len_val);
          rp = (rp + len_val) % CONFIG_SB_SIZE;
        } else {
          uint32_t part1 = CONFIG_SB_SIZE - rp;
          SDL_QueueAudio(dev, &sbuf[rp], part1);
          SDL_QueueAudio(dev, &sbuf[0], len_val - part1);
          rp = len_val - part1;
        }
      }
    }
  } else {
    // 读操作: 实时更新队列状态
    if (index == reg_count && dev) {
      // 计算尚未被设备取走的数据量
      uint32_t data_remain = (wp >= rp) ? (wp - rp) : (CONFIG_SB_SIZE - rp + wp);
      uint32_t sdl_queued = SDL_GetQueuedAudioSize(dev);
      audio_base[reg_count] = data_remain + sdl_queued;
    }
  }
}

void init_audio() {
  if (SDL_InitSubSystem(SDL_INIT_AUDIO) < 0) {
    Log("SDL audio init failed: %s", SDL_GetError());
    return;
  }

  uint32_t space_size = sizeof(uint32_t) * nr_reg;
  audio_base = (uint32_t *)new_space(space_size);
#ifdef CONFIG_HAS_PORT_IO
  add_pio_map ("audio", CONFIG_AUDIO_CTL_PORT, audio_base, space_size, audio_io_handler);
#else
  add_mmio_map("audio", CONFIG_AUDIO_CTL_MMIO, audio_base, space_size, audio_io_handler);
#endif

  sbuf = (uint8_t *)new_space(CONFIG_SB_SIZE);
  add_mmio_map("audio-sbuf", CONFIG_SB_ADDR, sbuf, CONFIG_SB_SIZE, NULL);

  audio_base[reg_sbuf_size] = CONFIG_SB_SIZE;
}
