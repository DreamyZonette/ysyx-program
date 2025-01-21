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
#include <assert.h>

/* We use the POSIX regex functions to process regular expressions.
 * Type 'man regex' for more information about POSIX regex functions.
 */
#include <regex.h>

enum {
  TK_NOTYPE = 256, TK_EQ,

  /* TODO: Add more token types */
	TK_MULTIPLY, TK_SUB,
	TK_DIVIDE, TK_NUM,
	TK_ID, TK_L, TK_R,
	TK_NEQ, TK_AND, TK_HEX,
	TK_REG,TK_EX
};

static struct rule {
  const char *regex;
  int token_type;
} rules[] = {

  /* TODO: Add more rules.
   * Pay attention to the precedence level of different rules.
   */

  {" +", TK_NOTYPE},    // spaces
  {"\\+", '+'},         // plus
  {"==", TK_EQ},        // equal
	{"\\*", TK_MULTIPLY},      // multiplied
	{"-", TK_SUB},				// 减法
	{"/", TK_DIVIDE},					// 除法
	{"[0-9]+", TK_NUM},
	{"[a-zA-Z]+", TK_ID},
	{"\\(", TK_L},
	{"\\)", TK_R},
	{"!=", TK_NEQ},// 新加
	{"&&", TK_AND},
	{"0x[0-9]+", TK_HEX},
	{"$", TK_REG},
	{"*", TK_EX}
};

#define NR_REGEX ARRLEN(rules)

static regex_t re[NR_REGEX] = {};

/* Rules are used for many times.
 * Therefore we compile them only once before any usage.
 */
void init_regex() {
  int i;
  char error_msg[128];
  int ret;

  for (i = 0; i < NR_REGEX; i ++) {
    ret = regcomp(&re[i], rules[i].regex, REG_EXTENDED);// 0 表示成功
    if (ret != 0) {
      regerror(ret, &re[i], error_msg, 128);
      panic("regex compilation failed: %s\n%s", error_msg, rules[i].regex);
    }
  }
}

typedef struct token {
  int type;
  char str[32];
} Token;

static Token tokens[32] __attribute__((used)) = {};
static int nr_token __attribute__((used))  = 0;

static bool make_token(char *e) {
  int position = 0;
  int i;
  regmatch_t pmatch;

  nr_token = 0;

  while (e[position] != '\0') {
    /* Try all rules one by one. */
    for (i = 0; i < NR_REGEX; i ++) {
      if (regexec(&re[i], e + position, 1, &pmatch, 0) == 0 && pmatch.rm_so == 0) {
        char *substr_start = e + position;
        int substr_len = pmatch.rm_eo;

        Log("match rules[%d] = \"%s\" at position %d with len %d: %.*s",
            i, rules[i].regex, position, substr_len, substr_len, substr_start);

        position += substr_len;

        /* TODO: Now  a new token is recognized with rules[i]. Add codes
         * to record the token in the array `tokens'. For certain types
         * of tokens, some extra actions should be performed.
         */

        switch (rules[i].token_type) {
					case '+':  
						strcpy(tokens[nr_token].str, "+");
						tokens[nr_token].type = '+';
						nr_token++;
						break;
					case TK_L:
						strcpy(tokens[nr_token].str, "(");
						tokens[nr_token].type = TK_L;
						nr_token++;
						break;
					case TK_R:
						strcpy(tokens[nr_token].str, ")");
						tokens[nr_token].type = TK_R;
						nr_token++;
						break;
					case TK_NOTYPE:
						break;
					case TK_EQ:
						strcpy(tokens[nr_token].str, "=");
						tokens[nr_token].type = TK_EQ;
						nr_token++;
						break;
					case TK_MULTIPLY:
						strcpy(tokens[nr_token].str, "*");
						tokens[nr_token].type = TK_MULTIPLY;
						nr_token++;
						break;
					case TK_SUB:
						strcpy(tokens[nr_token].str, "-");
						tokens[nr_token].type = TK_SUB;
						nr_token++;
						break;
					case TK_DIVIDE:
						strcpy(tokens[nr_token].str, "/");
						tokens[nr_token].type = TK_DIVIDE;
						nr_token++;
						break;
						// 接下来要重点调试
					case TK_NUM:
						{
						assert(pmatch.rm_so != -1);// 匹配是否成功
						char match[pmatch.rm_eo - pmatch.rm_so + 1];
						strncpy(match, e + position + pmatch.rm_so - 1, pmatch.rm_eo - pmatch.rm_so);// 获得数据
						match[pmatch.rm_eo - pmatch.rm_so] = '\0';
						assert(sizeof(match) <= 32);
						strcpy(tokens[nr_token].str, match);
						tokens[nr_token].type = TK_NUM;
						nr_token++;
						break;
						}
					case TK_ID:
						{
						assert(pmatch.rm_so != -1);
						char match[pmatch.rm_eo - pmatch.rm_so + 1];
						strncpy(match, e + position + pmatch.rm_so - 1, pmatch.rm_eo - pmatch.rm_so);
						match[pmatch.rm_eo - pmatch.rm_so] = '\0';
						assert(sizeof(match) <= 32);
						strcpy(tokens[nr_token].str, match);
						tokens[nr_token].type = TK_ID;
						nr_token++;
						break;
						}
          default: TODO(); 
        }
				//printf();
        break;
      }
    }

    if (i == NR_REGEX) {
      printf("no match at position %d\n%s\n%*.s^\n", position, e, position, "");
      return false;
    }
  }

  return true;
}

bool check_parentheses(int p, int q){
	// 判断是否合法
	if(p > q) return false;

	// 检测括号使用是否合法
	int open_count = 0 ,close_count = 0;
	for(int i = p; i <= q; i++){
		if(tokens[i].type == TK_L)  open_count++;// 左括号的数量
		if(tokens[i].type == TK_R)  close_count++;// 有括号的数量
		if(close_count > open_count) return false;// 如果出现如:( a ))的情况返回错误
		if(close_count == open_count && i != q) return false;// 如果出现形如(4 + 3) * (2 - 1)返回错误
	}

	// 检测数量是否成对	
	if(open_count != close_count) return false;// 不成对判断为错

	if(open_count == 0 && close_count == 0) return false;// 如果没有括号直接判断为错
	// 检测是否包围表达式
	if(tokens[p].type != TK_L || tokens[q].type != TK_R) {
		return false;// 如果第一位或者最后一位不是括号判断为错
	}
	return true;
}

int valid_index(int i, int pos_L, int pos_R, int q){

	if ((i < pos_L || pos_L == -1) || (i > pos_R || pos_R == q + 1)){
		return 1;
	}
	else {
		return 0;
	}
}


int eval(int p, int q, int* signal){
	if (p > q){
		printf("invalid expression: p > q\n");
		return 0;
	}
	else if (p == q){
		  return atoi(tokens[p].str);
	}
	else if (check_parentheses(p, q) == true){
	
		return eval(p + 1, q - 1, signal);
	}
	else {
		int op = -1;

		int ADD = -1;
		int SUB = -1;
		int MUL = -1;
		int DIV = -1;
		int pos_L = -1;
		int pos_R = q + 1;
		// 确定最大括号的位置
		for(int i = p; i <= q; i++){
			if (tokens[i].type == TK_L && pos_L == -1) {
				pos_L = i;
			}
			if (tokens[i].type == TK_R){
				pos_R = i;
			}
		}
		// 获得有效token位置
		for (int i = p; i <=q; i++){
			if (tokens[i].type == '+' && valid_index(i, pos_L, pos_R, q)){
				ADD = i;
			}
			if (tokens[i].type == TK_SUB && valid_index(i, pos_L, pos_R, q)){
				SUB = i;
			}
			if (tokens[i].type == TK_MULTIPLY && valid_index(i, pos_L, pos_R, q)){
				MUL = i;
			}
			if (tokens[i].type == TK_DIVIDE && valid_index(i, pos_L, pos_R, q)){
				DIV = i;
			}
		}

		if (ADD != -1) op = ADD;
		else if (SUB != -1) op = SUB;
		else if (MUL != -1) op = MUL;
		else if (DIV != -1) op = DIV;
		else {
			printf("op Error\n");
			return 0;
		}

		int val1 = eval(p, op - 1, signal);
		int val2 = eval(op + 1, q, signal);

		switch (tokens[op].type){
			case '+': 
				return val1 + val2;
			case TK_MULTIPLY:
				return val1 * val2;
			case TK_SUB:
				return val1 - val2;
			case TK_DIVIDE:
				if (val2 == 0){
					printf("除数不能为0\n");
					*signal = 1;
					return 0;
				}
				else {
				return val1 / val2;
				}
			default:
			  printf("Unsupported operator: %d\n", tokens[op].type);
				return 0;	
		}
	}
}

word_t expr(char *e, bool *success) {
  if (!make_token(e)) {
    *success = false;
		printf("make token Error\n");
    return 0;
  }

  /* TODO: Insert codes to evaluate the expression. */
	//make_token(e);
	// 计算表达式的值
	int signal = 0;
	int value = eval(0, nr_token - 1, &signal);
	if (signal != 1) printf("Expression: %s\nResult: %d\n",e,value);
  //TODO();

  return 0;
}
