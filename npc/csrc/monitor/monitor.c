#include <memory/paddr.h>
#include <utils.h>
#if CONFIG_FTRACE 
	#include "elf_reader.h"
#endif

//static char *img_file = NULL;
static char img_file[256] = {0};
static char elf_file[256] = {0};

void init_rand();
void init_mem();
void init_isa();
void sdb_set_batch_mode();
//void init_log(const char *log_file);


static void welcome() {
  // Log("Trace: %s", MUXDEF(CONFIG_TRACE, ANSI_FMT("ON", ANSI_FG_GREEN), ANSI_FMT("OFF", ANSI_FG_RED)));
  if(CONFIG_ITRACE == 1){
    printf("ITrace: %s\t", ANSI_FMT("ON", ANSI_FG_GREEN));
  }
  else{
    printf("ITrace: %s\t", ANSI_FMT("OFF", ANSI_FG_RED));
  }
  if(CONFIG_MTRACE == 1){
    printf("MTrace: %s\t", ANSI_FMT("ON", ANSI_FG_GREEN));
  }
  else{
    printf("MTrace: %s\t", ANSI_FMT("OFF", ANSI_FG_RED));
  }
  if(CONFIG_FTRACE == 1){
    printf("FTrace: %s\t", ANSI_FMT("ON", ANSI_FG_GREEN));
  }
  else{
    printf("FTrace: %s\t", ANSI_FMT("OFF", ANSI_FG_RED));
  }
  printf("\n");
  // IFDEF(CONFIG_TRACE, Log("If trace is enabled, a log file will be generated "
  //       "to record the trace. This may lead to a large log file. "
  //       "If it is not necessary, you can disable it in menuconfig"));
  printf("Build time: %s, %s\n", __TIME__, __DATE__);
  printf("Welcome to %s-NPC!\n", ANSI_FMT("riscv32e", ANSI_FG_YELLOW ANSI_BG_RED));
  printf("For help, type \"help\"\n");
}

static long load_img() {
  if (img_file[0] == '\0') {
    printf("No image is given. Use the default build-in image.\n");
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
    printf("The image is %s, size = %ld\n", img_file, size);
    fseek(fp, 0, SEEK_SET);
    int ret = fread(guest_to_host(RESET_VECTOR), size, 1, fp);
    assert(ret == 1);
    fclose(fp);
  
  return size;
}

static int parse_args(int argc, char *argv[]) {
    if(argc < 2){
        printf("Use default image.\n");
        img_file[0] = '\0';
        return 0;
    }
     for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-i") == 0 || strcmp(argv[i], "--image") == 0) {
          if (i + 1 < argc) {
              strncpy(img_file, argv[i + 1], sizeof(img_file) - 1);
              img_file[sizeof(img_file) - 1] = '\0'; // 确保终止
              printf("Using image: %s\n", img_file);
               //return 0;
          } else {
            printf("Error: Missing filename after %s\n", argv[i]);
            img_file[0] = '\0';
            //return 0;
          }
        }
        else if(strcmp(argv[i], "-b") == 0){
          sdb_set_batch_mode();
        }
        else if(strcmp(argv[i], "-e") == 0 || strcmp(argv[i], "--elf") == 0){
          if (i + 1 < argc) {
              strncpy(elf_file, argv[i + 1], sizeof(elf_file) - 1);
              elf_file[sizeof(elf_file) - 1] = '\0'; // 确保终止
              printf("Using elf file : %s\n", elf_file);
               //return 0;
          } else {
            printf("Error: Missing filename after %s\n", argv[i]);
            elf_file[0] = '\0';
            //return 0;
          }
          #if CONFIG_FTRACE
            extract_functions(elf_file);
          #endif
        }
    }
    
    return 0;
}

void init_monitor(int argc, char *argv[]) {
  //printf("%s\n", argv[1]);

  parse_args(argc, argv);

  init_rand();  

  //init_log(log_file);

  init_mem();

  init_isa();

  long img_size = load_img();

  welcome();
}