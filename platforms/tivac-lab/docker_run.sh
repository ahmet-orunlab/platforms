#!/bin/bash
docker rm -f tivac_running_container 2>/dev/null

docker run -d \
  --name tivac_running_container \
  --privileged \
  -p 2222:22 \
  -v /dev/bus/usb:/dev/bus/usb \
  -v $(pwd):/workspace \
  tivac-lab-env

echo "Tiva C Konteyneri izole SSH portuyla (2222) sunucuda baslatildi."
