#!/bin/bash

# VS Code'un GDB'ye göndereceği komutlardaki yerel yolu, Docker içindeki yola dönüştüren bir filtre (sed) ekliyoruz.
# Böylece "-environment-cd /home/ahmet/.../projects" komutu konteyner içinde "-environment-cd /workspace/projects" haline gelecek.

sed -b 's|/home/ahmet/orunlab/projs/platforms/msp430-lab/projects|/workspace/projects|g' | \
docker exec -i msp430_running_container msp430-gdb --interpreter=mi
