#!/bin/bash
docker rm -f stm32f4_running_container 2>/dev/null
docker build -t stm32f4-lab-env .

docker run -d \
  --name stm32f4_running_container \
  --privileged \
  -p 2222:22 \
  -v /dev/bus/usb:/dev/bus/usb \
  -v $(pwd)/.ssh_host_keys:/etc/ssh/ssh_host_keys \
  -v $(pwd)/projects:/workspace \
  stm32f4-lab-env

echo "STM32F4 Konteyneri izole SSH portuyla (2222) sunucuda baslatildi."
