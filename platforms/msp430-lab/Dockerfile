FROM ubuntu:22.04

# Geçilebilecek etkileşimli soruları engellemek için
ENV DEBIAN_FRONTEND=noninteractive

# Gerekli temel paketlerin, MSP430 derleyicisinin ve mspdebug aracının kurulması
RUN apt-get update && apt-get install -y \
    gcc-msp430 \
    msp430-libc \
    make \
    usbutils \
    mspdebug \
    libusb-1.0-0-dev \
    gcc \
    git \
    && apt-get clean

# mspdebug aracının en güncel TI-sub (tilib) sürücü desteğiyle kurulması (Launchpad emülatörü için)
#RUN apt-get update && apt-get install -y mspdebug

# Çalışma dizini oluşturma
WORKDIR /workspace

# GDB sunucusunu arka planda başlatacak betiği kopyala
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
