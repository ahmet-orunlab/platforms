#!/bin/bash

# Kullanım: ./set_breakpoint.sh <satır numarası1> <satır numarası2> ...
if [ $# -lt 1 ]; then
    echo "Usage: $0 <line_number1> <line_number2> ..."
    exit 1
fi

# ELF dosyasını otomatik bul
ELF_FILE=$(ls *.elf 2>/dev/null | head -n 1)

if [ -z "$ELF_FILE" ]; then
    echo "Error: No ELF file found in the current directory!"
    exit 1
fi

echo "Using ELF file: $ELF_FILE"

# MSPDebug komutlarını oluştur
BP_COMMANDS=""
for LINE_NUMBER in "$@"; do
    ADDRESS=$(msp430-objdump -Sl "$ELF_FILE" | grep -A 5 "main.c:$LINE_NUMBER" | grep -oP '^\s*\K[0-9a-f]+(?=:)' | head -n 1)

    if [ -z "$ADDRESS" ]; then
        echo "Error: Could not find address for line $LINE_NUMBER"
        continue
    fi

    echo "Setting breakpoint at address: 0x$ADDRESS (Line: $LINE_NUMBER)"
    BP_COMMANDS+="setbreak 0x$ADDRESS\n"
done

# Eğer hiç breakpoint bulunamazsa çık
if [ -z "$BP_COMMANDS" ]; then
    echo "No valid breakpoints found."
    exit 1
fi

# MSPDebug içinde komutları çalıştır
echo -e "$BP_COMMANDS" | mspdebug rf2500
