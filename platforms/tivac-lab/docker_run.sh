#!/bin/bash
set -e

DEVICE_SYMLINK="${TIVAC_DEVICE_SYMLINK:-/dev/tivac_icdi}"
DEVICE_ARGS=()

docker rm -f tivac_running_container 2>/dev/null || true
docker build -t tivac-lab-env .

if [ -e "$DEVICE_SYMLINK" ]; then
  printf 'Tiva C cihaz symlink bulundu: %s\n' "$DEVICE_SYMLINK"
  DEVICE_ARGS+=("--device=$DEVICE_SYMLINK")
else
  printf 'Uyari: Tiva C cihaz symlink bulunamadi: %s\n' "$DEVICE_SYMLINK"
  printf 'Konteyner yine /dev/bus/usb mountu ile baslatilacak.\n'
fi

docker run -d \
  --name tivac_running_container \
  --privileged \
  "${DEVICE_ARGS[@]}" \
  -p 2224:22 \
  -v /dev/bus/usb:/dev/bus/usb \
  -v $(pwd)/.ssh_host_keys:/etc/ssh/ssh_host_keys \
  -v $(pwd)/projects:/workspace \
  tivac-lab-env

echo "Tiva C Konteyneri izole SSH portuyla (2224) sunucuda baslatildi."
