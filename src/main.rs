#![no_main] // 告诉编译器没有一般意义上的 main 函数
#![no_std]  // 不使用 Rust 标准库，而使用核心库
#![feature(panic_info_message)]
mod lang_items;
mod sbi; // 引入 RustSBI
#[macro_use]
mod console;

// 将 entry.asm 转化为字符串，嵌入代码中
use core::arch::global_asm;
global_asm!(include_str!("entry.asm"));


#[no_mangle] // 避免编译器对它的名字进行混淆
pub fn rust_main() -> !{
    clear_bss();
    println!("Hello, world!");
    panic!("Shutdown machine!");
}

fn clear_bss() {
    extern "C" { // 引用外部的 C 函数接口
        fn sbss();
        fn ebss();
    }
    (sbss as usize..ebss as usize).for_each(|a| {
        unsafe { (a as *mut u8).write_volatile(0) }
    });
}