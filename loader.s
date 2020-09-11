.set MAGIC, 0x1badb002 # magic number to detect that this is a kernel
.set PAGE_ALIGN, 1<<0
.set MEMORY_INFO, 1 << 1

.set FLAGS, PAGE_ALIGN || MEMORY_INFO
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot
	.long MAGIC
	.long FLAGS
	.long CHECKSUM

.section .text
.extern kernelMain
.extern callConstructors
.global loader

loader:
	mov $kernel_stack, %esp /* setup stack */

	call callConstructors

	push %eax
	push %ebx
	call kernelMain

_stop: # loop
	cli
	hlt
	jmp _stop


.section .bss
.space 2*1024*1024 # 2 MiB
kernel_stack:
