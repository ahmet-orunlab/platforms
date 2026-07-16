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
    openssh-server \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# SSH Yapılandırması
RUN mkdir /var/run/sshd

# MÜŞTERİ KULLANICISI OLUŞTURMA (En kararlı yöntem)
# 'developer' adında şifresi 'msp123' olan bir kullanıcı oluşturuyoruz
RUN useradd -m -s /bin/bash -G sudo developer && \
    echo "developer:msp123" | chpasswd
    #usermod -aG sudo developer

# KRİTİK: developer kullanıcısına şifresiz sudo yetkisi veriyoruz
# Böylece arka planda çalışan VS Code görevleri şifre tıkanıklığına uğramaz
RUN echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
    
# Müşterinin VS Code klasörünü önceden oluşturup yetkisini developer'a teslim ediyoruz
RUN mkdir -p /home/developer/.vscode-server/extensions && \
    chown -R developer:developer /home/developer
    
# SSH üzerinden şifre ile girişe kesin olarak izin veriyoruz
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/Include \/etc\/ssh\/sshd_config.d\/\*\.conf/# Include \/etc\/ssh\/sshd_config.d\/\*\.conf/' /etc/ssh/sshd_config
# --- KRİTİK ADIM: VS Code Eklentilerini İmajın İçine Önceden Gömme ---
# VS Code Server'ın eklentileri container içinde tanıyabilmesi için global dizin oluşturuyoruz
RUN mkdir -p /home/developer/.vscode-server/extensions \
             /root/.vscode-server/extensions

# Çalışma alanı dizini oluşturma
RUN mkdir -p /workspace && chown -R developer:developer /workspace
WORKDIR /workspace

# Container başladığında SSH servisini arka planda değil, ön planda çalıştırıyoruz
CMD ["/usr/sbin/sshd", "-D"]
