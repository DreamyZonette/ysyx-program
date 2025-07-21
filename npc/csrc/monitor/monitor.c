#include <memory/paddr.h>
#include <isa.h>

static char *img_file = NULL;

void init_rand();
void init_mem();

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
    if(argc <= 1){
        printf("Use default image.");
    }
    else {
        printf("Use image:%s\n", argv[1]);
        strcpy(img_file, argv[1]);
    }

    return 0;
}

void init_monitor(int argc, char *argv[]) {

  parse_args(argc, argv);

  init_rand();  

  init_mem();

  init_isa();

  long img_size = load_img();
}