OUTPUT_ARCH(riscv) /*设置目标平台*/
ENTRY(_start)      /*设定程序入口点*/
BASE_ADDRESS = 0x80200000; /*设置初始化代码放置地址*/

SECTIONS
{
    /*'.' 表示当前地址*/
    . = BASE_ADDRESS;
    skernel = .; /*记录此刻位置*/

    stext = .;
    .text : {
        /*<ObjectFile>(SectionName)*/
        *(.text.entry) /*先放置 .text.entry*/
        *(.text .text.*)
    }

    . = ALIGN(4K); /*4K对齐*/
    etext = .;
    srodata = .;
    .rodata : {
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
    }

    . = ALIGN(4K);
    erodata = .;
    sdata = .;
    .data : {
        *(.data .data.*)
        *(.sdata .sdata.*)
    }

    . = ALIGN(4K);
    edata = .;
    .bss : {
        *(.bss.stack)
        sbss = .;
        *(.bss .bss.*)
        *(.sbss .sbss.*)
    }

    . = ALIGN(4K);
    ebss = .;
    ekernel = .;

    /DISCARD/ : {
        *(.eh_frame)
    }
}