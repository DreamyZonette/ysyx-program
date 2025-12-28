#include <utils.h>

NPCState npc_state = { 
    .state = NPC_STOP ,
    .halt_pc = 0,   // 或一个合理的默认值
    .halt_ret = 0   // 或一个合理的默认值
    };

int is_exit_status_bad() {
  int good = (npc_state.state == NPC_END && npc_state.halt_ret == 0) ||
    (npc_state.state == NPC_QUIT);
  return !good;
}