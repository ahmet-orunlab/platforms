#!/bin/bash
docker rm -f tivac_running_container 2>/dev/null
docker build -t tivac-lab-env .

docker run -d \
  --name tivac_running_container \
  --privileged \
  -p 2222:22 \
  -v /dev/bus/usb:/dev/bus/usb \
  -v $(pwd)/.ssh_host_keys:/etc/ssh/ssh_host_keys \
  -v $(pwd)/projects:/workspace \
  tivac-lab-env

echo "Tiva C Konteyneri izole SSH portuyla (2222) sunucuda baslatildi."
