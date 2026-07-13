# DÜZELTME: Konteyner içindeki gerçek derleyici adı msp430-gcc'dir
CC = msp430-gcc
MCU = msp430g2553

CFLAGS = -mmcu=$(MCU) -g -O0 -Iinclude
TARGET = build/main.elf

all: $(TARGET)

$(TARGET): src/main.c
	mkdir -p build
	$(CC) $(CFLAGS) src/main.c -o $(TARGET)

clean:
	rm -rf build
