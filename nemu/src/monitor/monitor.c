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

#include <isa.h>
#include <memory/paddr.h>
#include <elf.h>
#ifndef CONFIG_FTRACE 
//	void extract_functions(const char* elf_path);
	#include "elf_reader.h"
#endif

#define ELF_MAGIC 0x464C457F  // ELF文件魔数：0x7F 'E' 'L' 'F'

void init_rand();
void init_log(const char *log_file);
void init_mem();
void init_difftest(char *ref_so_file, long img_size, int port);
void init_device();
void init_sdb();
void init_disasm();

static void welcome() {
  Log("Trace: %s", MUXDEF(CONFIG_TRACE, ANSI_FMT("ON", ANSI_FG_GREEN), ANSI_FMT("OFF", ANSI_FG_RED)));
  IFDEF(CONFIG_TRACE, Log("If trace is enabled, a log file will be generated "
        "to record the trace. This may lead to a large log file. "
        "If it is not necessary, you can disable it in menuconfig"));
  Log("Build time: %s, %s", __TIME__, __DATE__);
  printf("Welcome to %s-NEMU!\n", ANSI_FMT(str(__GUEST_ISA__), ANSI_FG_YELLOW ANSI_BG_RED));
  printf("For help, type \"help\"\n");
}

#ifndef CONFIG_TARGET_AM
#include <getopt.h>

void sdb_set_batch_mode();

static char *log_file = NULL;
static char *diff_so_file = NULL;
static char *img_file = NULL;
static int difftest_port = 1234;


static long load_img() {
  if (img_file == NULL) {
    Log("No image is given. Use the default build-in image.");
    return 4096; // built-in image size
  }

  FILE *fp = fopen(img_file, "rb");
  Assert(fp, "Can not open '%s'", img_file);

  // 检查是否为ELF文件
  uint32_t magic;
  int ret = fread(&magic, sizeof(magic), 1, fp);
  assert(ret == 1);
  fseek(fp, 0, SEEK_SET); // 回到文件开头
  long size = 0;

  if (magic == ELF_MAGIC) {
    // ELF文件处理逻辑 - 关键改进部分
    Log("Loading ELF image: %s", img_file);
    
    // 读取ELF头
    Elf32_Ehdr ehdr;
    ret = fread(&ehdr, sizeof(ehdr), 1, fp);
    assert(ret == 1);
    
    // 查找第一个可加载段(PT_LOAD)作为基准
    Elf32_Phdr first_phdr;
    int found_load_segment = 0;
    uint32_t min_offset = UINT32_MAX;
    
    fseek(fp, ehdr.e_phoff, SEEK_SET);
    for (int i = 0; i < ehdr.e_phnum; i++) {
      Elf32_Phdr phdr;
      ret = fread(&phdr, sizeof(phdr), 1, fp);
      assert(ret == 1);
      
      // 记录第一个可加载段的信息
      if (phdr.p_type == PT_LOAD && phdr.p_offset < min_offset) {
        first_phdr = phdr;
        min_offset = phdr.p_offset;
        found_load_segment = 1;
      }
    }
    
    if (!found_load_segment) {
      panic("No PT_LOAD segment found in ELF file");
    }

    // 计算ELF文件的实际代码/数据大小
    fseek(fp, 0, SEEK_END);
    size = ftell(fp) - first_phdr.p_offset;
    fseek(fp, first_phdr.p_offset, SEEK_SET);
    
    // 关键改进：将ELF的有效内容加载到RESET_VECTOR
    ret = fread(guest_to_host(RESET_VECTOR), size, 1, fp);
    assert(ret == 1);
    
    Log("Loaded ELF segment at 0x%x, size = %ld", RESET_VECTOR, size);
    fclose(fp);
  }
  else {
    // BIN文件处理逻辑（保持不变）
    fseek(fp, 0, SEEK_END);
    size = ftell(fp);
    Log("The image is %s, size = %ld", img_file, size);
    fseek(fp, 0, SEEK_SET);
    ret = fread(guest_to_host(RESET_VECTOR), size, 1, fp);
    assert(ret == 1);
    fclose(fp);
  }
  return size;
}

static int parse_args(int argc, char *argv[]) {
  const struct option table[] = {
    {"batch"    , no_argument      , NULL, 'b'},
    {"log"      , required_argument, NULL, 'l'},
    {"diff"     , required_argument, NULL, 'd'},
    {"port"     , required_argument, NULL, 'p'},
    {"help"     , no_argument      , NULL, 'h'},
    {0          , 0                , NULL,  0 },
  };
  int o;
  while ( (o = getopt_long(argc, argv, "-bhl:d:p:", table, NULL)) != -1) {
    switch (o) {
      case 'b': sdb_set_batch_mode(); break;
      case 'p': sscanf(optarg, "%d", &difftest_port); break;
      case 'l': log_file = optarg; break;
      case 'd': diff_so_file = optarg; break;
      case 1: 
        img_file = optarg; 
        #ifndef CONFIG_FTRACE 
          printf("test\n");
          extract_functions(img_file);
        #endif
        return 0;
      default:
        printf("Usage: %s [OPTION...] IMAGE [args]\n\n", argv[0]);
        printf("\t-b,--batch              run with batch mode\n");
        printf("\t-l,--log=FILE           output log to FILE\n");
        printf("\t-d,--diff=REF_SO        run DiffTest with reference REF_SO\n");
        printf("\t-p,--port=PORT          run DiffTest with port PORT\n");
        printf("\n");
        exit(0);
    }
  }

  return 0;
}

void init_monitor(int argc, char *argv[]) {
  /* Perform some global initialization. */

  /* Parse arguments. */
  parse_args(argc, argv);

  /* Set random seed. */
  init_rand();

  /* Open the log file. */
  init_log(log_file);

  /* Initialize memory. */
  init_mem();

  /* Initialize devices. */
  IFDEF(CONFIG_DEVICE, init_device());

  /* Perform ISA dependent initialization. */
  init_isa();

  /* Load the image to memory. This will overwrite the built-in image. */
  long img_size = load_img();

  /* Initialize differential testing. */
  init_difftest(diff_so_file, img_size, difftest_port);

  /* Initialize the simple debugger. */
  init_sdb();

  IFDEF(CONFIG_ITRACE, init_disasm());

  /* Display welcome message. */
  welcome();
}
#else // CONFIG_TARGET_AM
static long load_img() {
  extern char bin_start, bin_end;
  size_t size = &bin_end - &bin_start;
  Log("img size = %ld", size);
  memcpy(guest_to_host(RESET_VECTOR), &bin_start, size);
  return size;
}

void am_init_monitor() {
  init_rand();
  init_mem();
  init_isa();
  load_img();
  IFDEF(CONFIG_DEVICE, init_device());
  welcome();
}
#endif
