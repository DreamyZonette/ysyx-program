#ifndef __RISCV_REG_H__
#define __RISCV_REG_H__

#include <common.h>

static inline int check_reg_idx(int idx) {
  assert(idx >= 0 && idx < 32);
  return idx;
}

uint32_t read_register(int idx) {
    // 设置作用域：绑定到 reg_file_u 实例
    char scope_path[256];
    sprintf(scope_path, "TOP.top.IDU_u.gpr_u.register_instances[%d].Reg_u", idx);
    
    svScope scope = svGetScopeFromName(scope_path);
    if (!scope) {
        fprintf(stderr, "Error: Scope not found: %s\n", scope_path);
        return 0;
    }
    svSetScope(scope);

    // 调用 DPI 函数
    uint32_t value = read_reg(idx);
    return value;
    // printf("Reg[%d] = 0x%08X\n", idx, value);
}

#define gpr(idx) (read_register(check_reg_idx(idx)))

static inline const char* reg_name(int idx) {
  extern const char* regs[];
  return regs[check_reg_idx(idx)];
}

#endif