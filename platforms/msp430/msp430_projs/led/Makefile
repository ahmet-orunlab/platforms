CC = msp430-gcc
CFLAGS = -mmcu=msp430g2553
SRC = main.c
OBJ = main.elf
HEX = main.hex

all: $(HEX)

$(OBJ): $(SRC)
	$(CC) $(CFLAGS) -o $(OBJ) $(SRC)

$(HEX): $(OBJ)
	msp430-objcopy -O ihex $(OBJ) $(HEX)

upload: $(HEX)
	mspdebug rf2500 "prog $(HEX)"

clean:
	rm -f $(OBJ) $(HEX)
