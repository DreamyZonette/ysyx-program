#include <am.h>
#include <klib.h>
#include <klib-macros.h>

#if !defined(__ISA_NATIVE__) || defined(__NATIVE_USE_KLIB__)
static unsigned long int next = 1;

int rand(void) {
  // RAND_MAX assumed to be 32767
  next = next * 1103515245 + 12345;
  return (unsigned int)(next/65536) % 32768;
}

void srand(unsigned int seed) {
  next = seed;
}

int abs(int x) {
  return (x < 0 ? -x : x);
}

int atoi(const char* nptr) {
  int x = 0;
  while (*nptr == ' ') { nptr ++; }
  while (*nptr >= '0' && *nptr <= '9') {
    x = x * 10 + *nptr - '0';
    nptr ++;
  }
  return x;
}

#if !(defined(__ISA_NATIVE__) && defined(__NATIVE_USE_KLIB__))
#define MEMORY_POOL_SIZE (32 * 1024 * 1024)
// 静态内存池
static uint8_t memory_pool[MEMORY_POOL_SIZE];

// 内存块结构
typedef struct mem_block {
    size_t size;            // 块大小（不包括头部）
    struct mem_block *next; // 指向下一个空闲块
    int free;               // 空闲标志 (1=空闲, 0=已分配)
} mem_block_t;

// 空闲链表头
static mem_block_t *free_list = (mem_block_t *)memory_pool;
// 初始化内存池
void init_memory_pool() {
    free_list->size = MEMORY_POOL_SIZE - sizeof(mem_block_t);
    free_list->next = NULL;
    free_list->free = 1;
}

// 对齐要求 (8字节对齐)
#define ALIGNMENT 8
#define ALIGN(size) (((size) + (ALIGNMENT-1)) & ~(ALIGNMENT-1))
#define BLOCK_SIZE sizeof(mem_block_t)

#endif

void *malloc(size_t size) {
  // On native, malloc() will be called during initializaion of C runtime.
  // Therefore do not call panic() here, else it will yield a dead recursion:
  //   panic() -> putchar() -> (glibc) -> malloc() -> panic()
#if !(defined(__ISA_NATIVE__) && defined(__NATIVE_USE_KLIB__))
  // panic("Not implemented");
  if (size == 0) return NULL;
  if (free_list == (mem_block_t *)memory_pool && free_list->size == 0) {
    init_memory_pool();
  }
  size = ALIGN(size);
  mem_block_t *current = free_list;
  //mem_block_t *prev = NULL;

  while (current!= NULL) {
    if (current->size >= size && current->free == 1) {
       // 检查是否可以分割块
      if (current->size >= size + sizeof(mem_block_t) + ALIGNMENT) {
        // 分割块
        mem_block_t *new_block = (mem_block_t *)((uint8_t *)(current + 1) + size);
        new_block->size = current->size - size - sizeof(mem_block_t);
        new_block->free = 1;
        new_block->next = current->next;
        current->size = size;
        current->next = new_block;
        // if (prev == NULL) {
        //   free_list = new_block;
        // } else {
        //   prev->next = new_block;
        // }
        // current->free = 0;
        return (void *)(current + 1);
      } 
    }
    //prev = current;
    current = current->next;
  }
  

#endif
  return NULL;
}

void free(void *ptr) {
  #if !(defined(__ISA_NATIVE__) && defined(__NATIVE_USE_KLIB__))
    if (ptr == NULL) return;
    
    // 获取内存块头部
    mem_block_t *block = (mem_block_t*)ptr - 1;
    block->free = 1;
    
    // 合并相邻空闲块
    mem_block_t *current = free_list;
   // mem_block_t *prev = NULL;
    
    while (current) {
        if (current->free) {
            // 检查是否可以与后续块合并
            mem_block_t *next = current->next;
            if (next && next->free && 
                (char*)current + BLOCK_SIZE + current->size == (char*)next) {
                current->size += BLOCK_SIZE + next->size;
                current->next = next->next;
                continue; // 继续检查是否可以进一步合并
            }
        }
        //prev = current;
        current = current->next;
    }
#endif
}

#endif
