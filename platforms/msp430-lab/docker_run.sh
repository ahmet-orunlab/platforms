#!/bin/bash

# 1. Eğer aynı isimde eski bir konteyner varsa çakışmayı önlemek için durdur ve sil
echo "Eski konteynerler temizleniyor..."
docker rm -f msp430_running_container 2>/dev/null

# 2. Dockerfile'ı oku ve 'msp430_image' adıyla yerel bir imaj olarak build et
echo "MSP430 Docker imaji build ediliyor..."
docker build -t msp430_image .

# 3. Build edilen bu yerel imajı tam yetki, tty desteği (-t) ve USB yönlendirmesiyle ayağa kaldır
echo "Konteyner baslatiliyor..."
docker run -d -t \
  --name msp430_running_container \
  --privileged \
  -v /dev/bus/usb:/dev/bus/usb \
  -v /dev:/dev \
  --device=/dev/msp430_launchpad \
  -p 3333:3333 \
  -v $(pwd)/projects:/workspace \
  msp430_image

echo "MSP430 Konteyneri basariyla calisti!"
