    # 表明期望内容被放置在 .text.entry；
    # 默认位置为 .text, .text.entry 能确保其放在更低的位置，即作为入口
    .section .text.entry 
    .globl _start        # 设置全局符号 _start
_start:
    la sp, boot_stack_top
    call rust_main

    .section .bss.stack
    .globl boot_stack
boot_stack: 
    .space 4096 * 16
    .globl boot_stack_top
boot_stack_top: