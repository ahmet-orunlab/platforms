#!/bin/bash
# Varsa eski konteyneri sessizce sil (hata fırlatmasını engellemek için 2>/dev/null ekledik)
docker rm -f msp430_running_container 2>/dev/null

# Konteyneri başlat
docker run -d \
  --name msp430_running_container \
  --privileged \
  -v /dev/bus/usb:/dev/bus/usb \
  -v $(pwd):/workspace \
  -p 2000:2000 \
  msp430-lab-env
