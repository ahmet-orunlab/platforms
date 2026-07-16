#!/bin/bash
set -e

docker rm -f arduino_uno_running_container 2>/dev/null || true
docker build -t arduino-uno-lab-env .

docker run -d \
  --name arduino_uno_running_container \
  --privileged \
  -p 2230:22 \
  -v /dev:/dev \
  -v $(pwd)/.ssh_host_keys:/etc/ssh/ssh_host_keys \
  -v $(pwd)/projects:/workspace \
  arduino-uno-lab-env

echo "Arduino Uno konteyneri izole SSH portuyla (2230) sunucuda baslatildi."
