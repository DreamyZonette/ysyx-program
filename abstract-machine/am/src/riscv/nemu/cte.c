#include <am.h>
#include <riscv/riscv.h>
#include <klib.h>

static Context* (*user_handler)(Event, Context*) = NULL;
//#define CONFIG_ETRACE

Context* __am_irq_handle(Context *c) {

  if (user_handler) {
    Event ev = {0};

    uint32_t cause = c->mcause;

    //int is_interrupt = (cause & 0x80000000)!= 0;
    //cause = cause & 0x7fffffff;

    switch (cause) {
      case 8:
      case 9:
      case 11:
        ev.event=EVENT_YIELD;
        #ifdef CONFIG_ETRACE
        printf("Trap: EVENT_YIELD\n"); 
        #endif
        break;
      default: ev.event = EVENT_ERROR; 
        #ifdef CONFIG_ETRACE
        printf("Trap: EVENT_ERROR\n"); 
        #endif
        break;
    }

    c = user_handler(ev, c);
    assert(c != NULL);
  }

  return c;
}

extern void __am_asm_trap(void);

bool cte_init(Context*(*handler)(Event, Context*)) {
  // initialize exception entry
  asm volatile("csrw mtvec, %0" : : "r"(__am_asm_trap));

  // register event handler
  user_handler = handler;

  return true;
}
// struct Context {
//   uintptr_t gpr[NR_REGS];
//   uintptr_t mcause;
//   uintptr_t mstatus;
//   uintptr_t mepc;
//   void *pdir;
// };

Context *kcontext(Area kstack, void (*entry)(void *), void *arg) {
  uintptr_t stack_top = (uintptr_t)kstack.end;
  Context *c = (Context*)(stack_top - sizeof(Context));
  c->mepc = (uintptr_t)entry;
  c->gpr[10] = (uintptr_t)arg;
  c->gpr[2] = stack_top;
  c->mstatus = 0x1800;
  return c;
}

void yield() {
#ifdef __riscv_e
  asm volatile("li a5, -1; ecall");
#else
  asm volatile("li a7, -1; ecall");
#endif
}

bool ienabled() {
  return false;
}

void iset(bool enable) {
}
