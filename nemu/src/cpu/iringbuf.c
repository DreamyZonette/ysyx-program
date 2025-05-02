#include <cpu/cpu.h>
#include <isa.h>
#include <memory/vaddr.h>

#ifdef CONFIG_IRINGBUF
// 定义环形缓冲区和索引
IRingBufEntry iringbuf[IRINGBUF_SIZE];
int iringbuf_index = 0;

// 向环形缓冲区添加一条指令记录
void iringbuf_add_inst(vaddr_t pc, uint32_t inst, const char *asm_str) {
  // 保存指令信息到当前位置
  iringbuf[iringbuf_index].pc = pc;
  iringbuf[iringbuf_index].inst = inst;
  
  // 复制反汇编文本
  strncpy(iringbuf[iringbuf_index].asm_buf, asm_str, sizeof(iringbuf[iringbuf_index].asm_buf) - 1);
  iringbuf[iringbuf_index].asm_buf[sizeof(iringbuf[iringbuf_index].asm_buf) - 1] = '\0';
  
  // 更新索引，实现环形效果
  iringbuf_index = (iringbuf_index + 1) % IRINGBUF_SIZE;
}

// 打印环形缓冲区内容
void print_iringbuf(vaddr_t pc) {
  printf("Instruction Ring Buffer (most recent %d instructions):\n", IRINGBUF_SIZE);
  
  // 找到出错指令在环形缓冲区中的位置
  int error_idx = -1;
  for (int i = 0; i < IRINGBUF_SIZE; i++) {
    if (iringbuf[i].pc == pc) {
      error_idx = i;
      break;
    }
  }
  
  // 从最旧的指令开始打印
  int start = (iringbuf_index) % IRINGBUF_SIZE;
  
  for (int i = 0; i < IRINGBUF_SIZE; i++) {
    int idx = (start + i) % IRINGBUF_SIZE;
    
    // 跳过未初始化的条目
    if (iringbuf[idx].pc == 0) continue;
    
    // 标记出错指令
    const char *marker = (idx == error_idx) ? "-->" : "   ";
    
    // 分离指令和操作数
    char instr[16] = {0};
    char operands[112] = {0};
    
    // 尝试分离指令和操作数（假设格式为"指令 操作数"）
    char *space = strchr(iringbuf[idx].asm_buf, ' ');
    if (space) {
      int instr_len = space - iringbuf[idx].asm_buf;
      strncpy(instr, iringbuf[idx].asm_buf, instr_len);
      instr[instr_len] = '\0';
      strcpy(operands, space + 1);
    } else {
      // 如果没有空格，整个字符串都是指令
      strcpy(instr, iringbuf[idx].asm_buf);
    }
    
    // 格式化输出，使用固定宽度的列
    printf("%s 0x%08x     %-16s  %-17s  %08x\n", 
           marker, (uint32_t)iringbuf[idx].pc, instr, operands, iringbuf[idx].inst);
  }
  printf("\n");
}
#endif
