CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

CFLAGS = -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -O0 -g -Wall
LDFLAGS = -T stm32f407.ld -nostartfiles

SRC = src/main.c src/startup_gcc.c
OBJ = build/main.o build/startup_gcc.o

all: build_dir build/firmware.bin

build_dir:
	mkdir -p build

build/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

build/firmware.elf: $(OBJ)
	$(CC) $(OBJ) $(LDFLAGS) -o $@

build/firmware.bin: build/firmware.elf
	$(OBJCOPY) -O binary $< $@

clean:
	rm -rf build
