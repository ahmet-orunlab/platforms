MCU = atmega328p
F_CPU = 16000000UL
CC = avr-gcc
OBJCOPY = avr-objcopy
SIZE = avr-size

CFLAGS = -mmcu=$(MCU) -DF_CPU=$(F_CPU) -Os -g -Wall -std=gnu11
OBJ = build/main.o

all: build/firmware.hex

build_dir:
	mkdir -p build

build/%.o: src/%.c | build_dir
	$(CC) $(CFLAGS) -c $< -o $@

build/firmware.elf: $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $@
	$(SIZE) --mcu=$(MCU) --format=avr $@

build/firmware.hex: build/firmware.elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

clean:
	rm -rf build

.PHONY: all build_dir clean
