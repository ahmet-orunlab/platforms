FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Gerekli tüm araçları ve SSH Server'ı kuruyoruz
RUN apt-get update && apt-get install -y \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    make \
    lm4flash \
    openocd \
    gdb-multiarch \
    openssh-server \
    sudo \
    tar \
    curl \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# SSH Yapılandırması
RUN mkdir /var/run/sshd

# MÜŞTERİ KULLANICISI OLUŞTURMA (En kararlı yöntem)
# 'developer' adında şifresi 'tiva123' olan bir kullanıcı oluşturuyoruz
RUN useradd -m -s /bin/bash -G sudo developer && \
    echo "developer:tiva123" | chpasswd
    #usermod -aG sudo developer
    
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
