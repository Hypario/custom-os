ASPARAMS = --32
LDPARAMS = -m elf_i386

C_WARNING_FLAGS = -Wwrite-strings
C_FLAVOR_FLAGS = -fno-exceptions -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-leading-underscore

ARCH_FLAGS = -m32

C_FLAGS = $(C_FLAVOR_FLAGS) $(ARCH_FLAGS) $(C_WARNING_FLAGS)

objects = loader.o gdt.o kernel.o

%.o: %.cpp
		g++ $(C_FLAGS) -o $@ -c $<

%.o: %.s
		as $(ASPARAMS) -o $@ $<

clean:
	find . \( -name "*.o" -o -name "*.iso" -o -name "*.bin" \) -delete

build: linker.ld $(objects)
		ld $(LDPARAMS) -T $< -o myKernel.bin $(objects)