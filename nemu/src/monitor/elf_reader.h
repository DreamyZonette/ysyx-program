#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <elf.h>

// 读取ELF文件并提取函数名
void extract_functions(const char* elf_path) {
    FILE* fp = fopen(elf_path, "rb");
    if (!fp) {
        perror("Failed to open file");
        return;
    }

    // 1. 读取ELF头部
    Elf32_Ehdr ehdr;
    fread(&ehdr, sizeof(Elf32_Ehdr), 1, fp);
    // 2. 定位节区头部表
    fseek(fp, ehdr.e_shoff, SEEK_SET);
    Elf32_Shdr shdr[ehdr.e_shnum];
    fread(shdr, sizeof(Elf32_Shdr), ehdr.e_shnum, fp);

    // 3. 获取.shstrtab（节区名称表）
    Elf32_Shdr shstrtab_hdr = shdr[ehdr.e_shstrndx];
    char shstrtab[shstrtab_hdr.sh_size];
    fseek(fp, shstrtab_hdr.sh_offset, SEEK_SET);
    fread(shstrtab, shstrtab_hdr.sh_size, 1, fp);

    // 4. 查找.symtab和.strtab节区
    Elf32_Shdr symtab_hdr, strtab_hdr;
    int found_symtab = 0, found_strtab = 0;

    for (int i = 0; i < ehdr.e_shnum; i++) {
        char* name = shstrtab + shdr[i].sh_name;
        
        if (strcmp(name, ".symtab") == 0) {
            symtab_hdr = shdr[i];
            found_symtab = 1;
        } else if (strcmp(name, ".strtab") == 0) {
            strtab_hdr = shdr[i];
            found_strtab = 1;
        }
    }

    if (!found_symtab || !found_strtab) {
        fprintf(stderr, "Required sections not found\n");
        fclose(fp);
        return;

    // 5. 读取.strtab内容
    char* strtab = malloc(strtab_hdr.sh_size);
    fseek(fp, strtab_hdr.sh_offset, SEEK_SET);
    fread(strtab, strtab_hdr.sh_size, 1, fp);

    // 6. 解析.symtab，提取函数名
    int sym_count = symtab_hdr.sh_size / symtab_hdr.sh_entsize;
    Elf32_Sym* symbols = malloc(symtab_hdr.sh_size);
    fseek(fp, symtab_hdr.sh_offset, SEEK_SET);
    fread(symbols, symtab_hdr.sh_size, 1, fp);

    printf("Found functions:\n");
    for (int i = 0; i < sym_count; i++) {
        unsigned char type = ELF32_ST_TYPE(symbols[i].st_info);
        if (type == STT_FUNC) {  // 过滤函数符号
            char* func_name = strtab + symbols[i].st_name;
            printf("  [%d] %s\n", i, func_name);
        }
    }

    // 7. 清理资源
    free(strtab);
    free(symbols);
    fclose(fp);
}
/*
int ftrace_entry(int argc, char** argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <elf_file>\n", argv[0]);
        return 1;
    }
    extract_functions(argv[1]);
    return 0;
}
*/
