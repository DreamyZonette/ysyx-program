#ifndef __NVBOARD_H__
#define __NVBOARD_H__

#include <include/pins.h>
#include <include/font.h>
#include <include/render.h>
#include <include/component.h>
#include <include/configs.h>
#include <include/string>
#include <include/SDL.h>
#include <include/SDL_image.h>

#define VERSION_STR "v1.0 (2024.01.10)"

void set_redraw();
uint64_t nvboard_get_time();

void init_render(SDL_Renderer *renderer);
SDL_Texture* load_pic_texture(SDL_Renderer *renderer, std::string path);
SDL_Texture* new_texture(SDL_Renderer *renderer, int w, int h, int r, int g, int b);

#endif
