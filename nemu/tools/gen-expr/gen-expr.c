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

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>
#include <string.h>

// this should be enough
static char buf[65536] = {};
static char code_buf[65536 + 128] = {}; // a little larger than `buf`
static char *code_format =
"#include <stdio.h>\n"
"int main() { "
"  unsigned result = %s; "
"  printf(\"%%u\", result); "
"  return 0; "
"}";

uint32_t choose (uint32_t n) {
	return rand() % n;
}
// 待完成
void gen_num(){
	uint32_t num = rand() % 2147483648;
	char str[10];
	snprintf(str, sizeof(str), "%u", num);
	strncat(buf, str, sizeof(buf) - strlen(buf));
}

void gen(char* str){
	strncat(buf, str, sizeof(buf) - strlen(buf));
}

void gen_blank(){
	switch (choose(1)){
		case 0: strncat(buf, "", sizeof(buf) - strlen(buf)); break;
		case 1: strncat(buf, " ", sizeof(buf) - strlen(buf)); break;
		case 2: strncat(buf, "  ", sizeof(buf) - strlen(buf)); break;
		case 3: strncat(buf, "   ", sizeof(buf) - strlen(buf)); break;
	}
}

void gen_rand_op(){
	switch (choose(4)) {
		case 0: strncat(buf, "+", sizeof(buf) - strlen(buf)); break;
		case 1: strncat(buf, "-", sizeof(buf) - strlen(buf)); break;
		case 2: strncat(buf, "*", sizeof(buf) - strlen(buf)); break;
		case 3: strncat(buf, "/", sizeof(buf) - strlen(buf)); break;
	}

}

static void gen_rand_expr() {
	switch (choose(3)) {
		case 0: gen_blank(); gen_num(); gen_blank(); break; 
		case 1: gen_blank(); gen("("); gen_blank(); gen_rand_expr(); gen_blank(); gen(")"); gen_blank(); break;
		default: gen_blank(); gen_rand_expr(); gen_blank(); gen_rand_op(); gen_blank(); gen_rand_expr(); gen_blank(); break;
	}
  //buf[0] = '\0';
}

int main(int argc, char *argv[]) {
  int seed = time(0);
  srand(seed);
  int loop = 1;
  if (argc > 1) {
    sscanf(argv[1], "%d", &loop);
  }
  int i;
  for (i = 0; i < loop; i ++) {
    gen_rand_expr();

    sprintf(code_buf, code_format, buf);

    FILE *fp = fopen("/tmp/.code.c", "w");
    assert(fp != NULL);
    fputs(code_buf, fp);
    fclose(fp);

    int ret = system("gcc /tmp/.code.c -o /tmp/.expr");
    if (ret != 0) continue;

    fp = popen("/tmp/.expr", "r");
    assert(fp != NULL);

    int result;
    ret = fscanf(fp, "%d", &result);
    pclose(fp);

    printf("%u %s\n", result, buf);
		buf[0] = '\0'; // 清除buf内容
  }
  return 0;
}
