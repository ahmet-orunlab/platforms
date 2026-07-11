#!/bin/bash
# VS Code tek parça gönderse bile gelen komutu kelimelerine ayırıp temiz çalıştırır
docker exec -i msp430_running_container /usr/bin/msp430-elf-gdb $2
