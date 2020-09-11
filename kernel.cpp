#include "types.h"
#include "gdt.h"

void printf(const char* string)
{
	static uint16_t* VideoMemory = (uint16_t*)0xb8000;

	// puts string in video memory without overwritting color attributes
	for (int i = 0; string[i] != '\0'; ++i)
		VideoMemory[i] = (VideoMemory[i] & 0xFF00) | string[i];
}

typedef void (*constructor)();
extern "C" constructor start_ctors;
extern "C" constructor end_ctors;

extern "C" void callConstructors()
{
	for (constructor* i = &start_ctors; i != &end_ctors; i++) {
		(*i)();
	}
}

extern "C" void kernelMain(void* multiboot_structure, uint32_t multiboot_magic)
{
	printf("Hello World !");

	GlobalDescriptorTable gdt;

	while (true);
}