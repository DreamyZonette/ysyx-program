#include <memory/paddr.h>

static char *img_file = NULL;

static int parse_args(int argc, char *argv[]) {
    if(argc <= 1){
        printf("Use default image.");
    }
    else {
        printf("Use image:%s\n", argv[1]);
        strcpy(img_file, argv[1]);
    }
}

void init_monitor(int argc, char *argv[]) {
  parse_args(argc, argv);
}