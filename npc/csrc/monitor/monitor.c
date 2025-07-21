#include <memory/paddr.h>
#include <utils.h>

//static char *img_file = NULL;
static char img_file[1024] = {0};

void init_rand();
void init_mem();
void init_isa();


static void welcome() {
//   Log("Trace: %s", MUXDEF(CONFIG_TRACE, ANSI_FMT("ON", ANSI_FG_GREEN), ANSI_FMT("OFF", ANSI_FG_RED)));
//   Log("ITrace: %s", MUXDEF(CONFIG_ITRACE, ANSI_FMT("ON", ANSI_FG_GREEN), ANSI_FMT("OFF", ANSI_FG_RED)));
//   Log("MTrace: %s", MUXDEF(CONFIG_MTRACE, ANSI_FMT("ON", ANSI_FG_GREEN), ANSI_FMT("OFF", ANSI_FG_RED)));
//   Log("FTrace: %s", MUXDEF(CONFIG_FTRACE, ANSI_FMT("ON", ANSI_FG_GREEN), ANSI_FMT("OFF", ANSI_FG_RED)));
//   IFDEF(CONFIG_TRACE, Log("If trace is enabled, a log file will be generated "
//         "to record the trace. This may lead to a large log file. "
//         "If it is not necessary, you can disable it in menuconfig"));
  printf("Build time: %s, %s\n", __TIME__, __DATE__);
  printf("Welcome to %s-NPC!\n", ANSI_FMT("riscv32e", ANSI_FG_YELLOW ANSI_BG_RED));
  printf("For help, type \"help\"\n");
}

static long load_img() {
  if (img_file == NULL) {
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
        printf("Use default image.");
        img_file[0] = '\0';
        return 0;
    }
     for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-i") == 0 || strcmp(argv[i], "--image") == 0) {
          if (i + 1 < argc) {
              strncpy(img_file, argv[i + 1], sizeof(img_file) - 1);
              img_file[sizeof(img_file) - 1] = '\0'; // 确保终止
              printf("Using image: %s\n", img_file);
               return 0;
          } else {
            printf("Error: Missing filename after %s\n", argv[i]);
            img_file[0] = '\0';
            return 0;
          }
        }
    }
    
    return 0;
}

void init_monitor(int argc, char *argv[]) {
  //printf("%s\n", argv[1]);

  parse_args(argc, argv);

  init_rand();  

  init_mem();

  init_isa();

  long img_size = load_img();

  welcome();
}