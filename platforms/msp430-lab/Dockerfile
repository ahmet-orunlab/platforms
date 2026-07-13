FROM ubuntu:22.04

# Etkileşimli soruları engelle
ENV DEBIAN_FRONTEND=noninteractive

# Sadece kararlı, paket bazlı araçlar
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    gcc-msp430 \
    gdb-msp430 \
    mspdebug \
    libusb-1.0-0-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
