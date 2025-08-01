#include <memory/paddr.h>
#include <utils.h>
#if CONFIG_FTRACE 
	#include "elf_reader.h"
#endif

//static char *img_file = NULL;
static char img_file[256] = {0};
static char log_file[256] = {0};
static char elf_file[256] = {0};
static char diff_so_file[256] = {0};
static int difftest_port = 1234;

void init_rand();
void init_mem();
void init_isa();
void sdb_set_batch_mode();
void init_difftest(char *ref_so_file, long img_size, int port);
void init_log(const char *log_file);
void init_device();

extern unsigned char npc_logo[];
// unsigned char npc_logo[] = {// minirv
//   0x0a, 0x20, 0x5f, 0x5f, 0x20, 0x20, 0x20, 0x20, 0x5f, 0x5f, 0x20, 0x20,
//   0x5f, 0x5f, 0x20, 0x20, 0x5f, 0x5f, 0x20, 0x20, 0x20, 0x5f, 0x5f, 0x20,
//   0x20, 0x5f, 0x5f, 0x20, 0x20, 0x5f, 0x5f, 0x5f, 0x5f, 0x5f, 0x5f, 0x20,
//   0x20, 0x5f, 0x5f, 0x20, 0x20, 0x20, 0x5f, 0x5f, 0x5f, 0x5f, 0x20, 0x20,
//   0x20, 0x5f, 0x5f, 0x20, 0x20, 0x5f, 0x5f, 0x5f, 0x5f, 0x5f, 0x5f, 0x20,
//   0x20, 0x5f, 0x5f, 0x5f, 0x5f, 0x5f, 0x5f, 0x20, 0x20, 0x20, 0x0a, 0x2f,
//   0x5c, 0x20, 0x22, 0x2d, 0x2e, 0x2f, 0x20, 0x20, 0x5c, 0x2f, 0x5c, 0x20,
//   0x5c, 0x2f, 0x5c, 0x20, 0x22, 0x2d, 0x2e, 0x5c, 0x20, 0x5c, 0x2f, 0x5c,
//   0x20, 0x5c, 0x2f, 0x5c, 0x20, 0x20, 0x3d, 0x3d, 0x20, 0x5c, 0x2f, 0x5c,
//   0x20, 0x5c, 0x20, 0x2f, 0x20, 0x2f, 0x5c, 0x20, 0x22, 0x2d, 0x2e, 0x5c,
//   0x20, 0x5c, 0x2f, 0x5c, 0x20, 0x20, 0x3d, 0x3d, 0x20, 0x5c, 0x2f, 0x5c,
//   0x20, 0x20, 0x5f, 0x5f, 0x5f, 0x5c, 0x20, 0x20, 0x0a, 0x5c, 0x20, 0x5c,
//   0x20, 0x5c, 0x2d, 0x2e, 0x2f, 0x5c, 0x20, 0x5c, 0x20, 0x5c, 0x20, 0x5c,
//   0x20, 0x5c, 0x20, 0x5c, 0x2d, 0x2e, 0x20, 0x20, 0x5c, 0x20, 0x5c, 0x20,
//   0x5c, 0x20, 0x5c, 0x20, 0x20, 0x5f, 0x5f, 0x3c, 0x5c, 0x20, 0x5c, 0x20,
//   0x5c, 0x27, 0x2f, 0x5c, 0x20, 0x5c, 0x20, 0x5c, 0x2d, 0x2e, 0x20, 0x20,
//   0x5c, 0x20, 0x5c, 0x20, 0x20, 0x5f, 0x2d, 0x2f, 0x5c, 0x20, 0x5c, 0x20,
//   0x5c, 0x5f, 0x5f, 0x5f, 0x5f, 0x20, 0x0a, 0x20, 0x5c, 0x20, 0x5c, 0x5f,
//   0x5c, 0x20, 0x5c, 0x20, 0x5c, 0x5f, 0x5c, 0x20, 0x5c, 0x5f, 0x5c, 0x20,
//   0x5c, 0x5f, 0x5c, 0x5c, 0x22, 0x5c, 0x5f, 0x5c, 0x20, 0x5c, 0x5f, 0x5c,
//   0x20, 0x5c, 0x5f, 0x5c, 0x20, 0x5c, 0x5f, 0x5c, 0x20, 0x5c, 0x5f, 0x5f,
//   0x7c, 0x20, 0x5c, 0x20, 0x5c, 0x5f, 0x5c, 0x5c, 0x22, 0x5c, 0x5f, 0x5c,
//   0x20, 0x5c, 0x5f, 0x5c, 0x20, 0x20, 0x20, 0x5c, 0x20, 0x5c, 0x5f, 0x5f,
//   0x5f, 0x5f, 0x5f, 0x5c, 0x0a, 0x20, 0x20, 0x5c, 0x2f, 0x5f, 0x2f, 0x20,
//   0x20, 0x5c, 0x2f, 0x5f, 0x2f, 0x5c, 0x2f, 0x5f, 0x2f, 0x5c, 0x2f, 0x5f,
//   0x2f, 0x20, 0x5c, 0x2f, 0x5f, 0x2f, 0x5c, 0x2f, 0x5f, 0x2f, 0x5c, 0x2f,
//   0x5f, 0x2f, 0x20, 0x2f, 0x5f, 0x2f, 0x5c, 0x2f, 0x5f, 0x2f, 0x20, 0x20,
//   0x20, 0x5c, 0x2f, 0x5f, 0x2f, 0x20, 0x5c, 0x2f, 0x5f, 0x2f, 0x5c, 0x2f,
//   0x5f, 0x2f, 0x20, 0x20, 0x20, 0x20, 0x5c, 0x2f, 0x5f, 0x5f, 0x5f, 0x5f,
//   0x5f, 0x2f, 0x0a, '\0'
// };


static void welcome() {
  if (CONFIG_TRACE == 1){
    Log("Trace: %s", ANSI_FMT("ON", ANSI_FG_GREEN));
  }
  else{
    Log("Trace: %s", ANSI_FMT("OFF", ANSI_FG_RED));
  }
  #if CONFIG_TRACE
  if(CONFIG_ITRACE == 1){
    Log("ITrace: %s", ANSI_FMT("ON", ANSI_FG_GREEN));
  }
  else{
    Log("ITrace: %s", ANSI_FMT("OFF", ANSI_FG_RED));
  }
  if(CONFIG_MTRACE == 1){
    Log("MTrace: %s", ANSI_FMT("ON", ANSI_FG_GREEN));
  }
  else{
    Log("MTrace: %s", ANSI_FMT("OFF", ANSI_FG_RED));
  }
  if(CONFIG_FTRACE == 1){
    Log("FTrace: %s", ANSI_FMT("ON", ANSI_FG_GREEN));
  }
  else{
    Log("FTrace: %s", ANSI_FMT("OFF", ANSI_FG_RED));
  }
  #endif
  if(CONFIG_TRACE == 1){
    Log("If trace is enabled, a log file will be generated "
        "to record the trace. This may lead to a large log file. "
        "If it is not necessary, you can disable it in generated/autoconf.h");
    }
  Log("Build time: %s, %s", __TIME__, __DATE__);
  printf("Welcome to %s-NPC!\n", ANSI_FMT("riscv32e", ANSI_FG_YELLOW ANSI_BG_RED));
  printf("For help, type \"help\"\n");
  printf("\33[1;33m%s\33[0m\n\n",npc_logo);
}

static long load_img() {
  if (img_file[0] == '\0') {
    Log("No image is given. Use the default build-in image.");
    return 4096; // built-in image size
  }

  FILE *fp = fopen(img_file, "rb");
  if(!fp) {
    printf("Can not open '%s'\n", img_file);
    assert(1); // 断言失败，程序退出
  }

    fseek(fp, 0, SEEK_SET); // 回到文件开头
    long size = 0;

    // BIN文件处理逻辑（保持不变）
    fseek(fp, 0, SEEK_END);
    size = ftell(fp);
    Log("The image is %s, size = %ld", img_file, size);
    fseek(fp, 0, SEEK_SET);
    int ret = fread(guest_to_host(RESET_VECTOR), size, 1, fp);
    assert(ret == 1);
    fclose(fp);
  
  return size;
}

static int parse_args(int argc, char *argv[]) {
    if(argc < 2){
        Log("Use default image.");
        img_file[0] = '\0';
        return 0;
    }
     for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-i") == 0 || strcmp(argv[i], "--image") == 0) {
          if (i + 1 < argc) {
              strncpy(img_file, argv[i + 1], sizeof(img_file) - 1);
              img_file[sizeof(img_file) - 1] = '\0'; // 确保终止
              Log("Using image: %s", img_file);
               //return 0;
          } else {
            Log("Error: Missing filename after %s", argv[i]);
            img_file[0] = '\0';
            //return 0;
          }
        }
        else if(strcmp(argv[i], "-b") == 0 || strcmp(argv[i], "--batch") == 0){
          sdb_set_batch_mode();
        }
        else if (strcmp(argv[i], "-l") == 0 || strcmp(argv[i], "--log") == 0) {
          if (i + 1 < argc) {
              strncpy(log_file, argv[i + 1], sizeof(log_file) - 1);
              log_file[sizeof(log_file) - 1] = '\0'; // 确保终止
              Log("Using log file: %s", log_file);
               //return 0;
          } else {
            Log("Error: Missing filename after %s", argv[i]);
            log_file[0] = '\0';
            //return 0;
          }
        }
        else if(strcmp(argv[i], "-b") == 0 || strcmp(argv[i], "--batch") == 0){
          sdb_set_batch_mode();
        }
        #if CONFIG_FTRACE
        else if(strcmp(argv[i], "-e") == 0 || strcmp(argv[i], "--elf") == 0){
          if (i + 1 < argc) {
              strncpy(elf_file, argv[i + 1], sizeof(elf_file) - 1);
              elf_file[sizeof(elf_file) - 1] = '\0'; // 确保终止
              Log("Using elf file : %s", elf_file);
               //return 0;
          } else {
            Log("Error: Missing filename after %s", argv[i]);
            elf_file[0] = '\0';
            //return 0;
          }
            extract_functions(elf_file);
        }
        #endif
        #if CONFIG_DIFFTEST
        else if(strcmp(argv[i], "-d") == 0 || strcmp(argv[i], "--diff") == 0){
          if (i + 1 < argc) {
              strncpy(diff_so_file, argv[i + 1], sizeof(diff_so_file) - 1);
              diff_so_file[sizeof(diff_so_file) - 1] = '\0'; // 确保终止
              Log("Using diff so file : %s", diff_so_file);
               //return 0;
          } else {
            Log("Error: Missing filename after %s", argv[i]);
            diff_so_file[0] = '\0';
            //return 0;
          }
        }
        #endif
    }
    
    return 0;
}

void init_monitor(int argc, char *argv[]) {
  //printf("%s\n", argv[1]);

  parse_args(argc, argv);

  init_rand();  
  #if CONFIG_LOG
  init_log(log_file);
  #endif

  init_mem();

  init_isa();

  long img_size = load_img();
  #if CONFIG_DIFFTEST
  init_difftest(diff_so_file, img_size, difftest_port);
  #endif

  init_device();
  
  welcome();
}