#!/bin/bash
set -e

DEVICE_SYMLINK="${STM32_DEVICE_SYMLINK:-/dev/stm32_stlink}"
DEVICE_ARGS=()

docker rm -f stm32f4_running_container 2>/dev/null || true
docker build -t stm32f4-lab-env .

if [ -e "$DEVICE_SYMLINK" ]; then
  printf 'STM32 cihaz symlink bulundu: %s\n' "$DEVICE_SYMLINK"
  DEVICE_ARGS+=("--device=$DEVICE_SYMLINK")
else
  printf 'Uyari: STM32 cihaz symlink bulunamadi: %s\n' "$DEVICE_SYMLINK"
  printf 'Konteyner yine /dev/bus/usb mountu ile baslatilacak.\n'
fi

docker run -d \
  --name stm32f4_running_container \
  --privileged \
  "${DEVICE_ARGS[@]}" \
  -p 2222:22 \
  -v /dev/bus/usb:/dev/bus/usb \
  -v $(pwd)/.ssh_host_keys:/etc/ssh/ssh_host_keys \
  -v $(pwd)/projects:/workspace \
  stm32f4-lab-env

echo "STM32F4 Konteyneri izole SSH portuyla (2222) sunucuda baslatildi."
