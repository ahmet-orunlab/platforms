#!/bin/bash
set -e

DEVICE_SYMLINK="${MSP430_DEVICE_SYMLINK:-/dev/msp430_launchpad}"
DEVICE_ARGS=()

printf 'Eski konteynerler temizleniyor...\n'
docker rm -f msp430_running_container 2>/dev/null || true

printf 'MSP430 Docker imaji build ediliyor...\n'
docker build -t msp430-lab-env .

# Udev tarafinda sabit bir symlink tanimlandiysa cihaza ozel gecis olarak ekle.
# Symlink yoksa /dev ve /dev/bus/usb mountlari sayesinde yine devam ederiz.
if [ -e "$DEVICE_SYMLINK" ]; then
  printf 'MSP430 cihaz symlink bulundu: %s\n' "$DEVICE_SYMLINK"
  DEVICE_ARGS+=("--device=$DEVICE_SYMLINK")
else
  printf 'Uyari: MSP430 cihaz symlink bulunamadi: %s\n' "$DEVICE_SYMLINK"
  printf 'Konteyner yine /dev ve /dev/bus/usb mountlari ile baslatilacak.\n'
fi

printf 'Konteyner baslatiliyor...\n'
docker run -d -t \
  --name msp430_running_container \
  --privileged \
  -v /dev/bus/usb:/dev/bus/usb \
  -v /dev:/dev \
  "${DEVICE_ARGS[@]}" \
  -p 3333:3333 \
  -p 2223:22 \
  -v $(pwd)/.ssh_host_keys:/etc/ssh/ssh_host_keys \
  -v $(pwd)/projects:/workspace \
  msp430-lab-env

printf 'MSP430 Konteyneri basariyla calisti! SSH portu: 2223\n'
