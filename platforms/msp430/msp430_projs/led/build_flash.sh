#!/bin/bash

# Source and output files
SOURCE_FILE="main.c"
OUTPUT_FILE="main.elf"

# MCU type
MCU_TYPE="msp430g2553"

# Log file
LOG_FILE="build_log.log"

# Log function
log() {
    local TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$TIMESTAMP] $1" | tee -a $LOG_FILE
}

# Compiling
log "MCU: Compiling for $MCU_TYPE ..."
msp430-gcc -mmcu=$MCU_TYPE -g -O0 -o $OUTPUT_FILE $SOURCE_FILE &>> $LOG_FILE

# Error check
if [ $? -ne 0 ]; then
    log "Compiling failed!"
    exit 1
fi
log "Compiling successfull."

# Erasing flash memory
log "Erasing flash memory..."
mspdebug rf2500 erase &>> $LOG_FILE

# Programming Device
log "Programming device..."
mspdebug rf2500 "load $OUTPUT_FILE" &>> $LOG_FILE

# Error check
if [ $? -ne 0 ]; then
    log "Programming failed!"
    exit 1
fi

# Programı çalıştırma
log "Program running..."
mspdebug rf2500 run &>> $LOG_FILE

log "Program done successfully."

