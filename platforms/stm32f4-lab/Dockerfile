FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Gerekli tüm araçları ve SSH Server'ı kuruyoruz
RUN apt-get update && apt-get install -y \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    make \
    openocd \
    stlink-tools \
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

# Geliştirici kullanıcısı oluşturma
RUN useradd -m -s /bin/bash -G sudo developer && \
    echo "developer:stm123" | chpasswd
    
# VS Code klasörünü önceden oluşturup yetkisini developer'a teslim ediyoruz
RUN mkdir -p /home/developer/.vscode-server/extensions && \
    chown -R developer:developer /home/developer
    
# SSH üzerinden şifre ile girişe kesin olarak izin veriyoruz
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/Include \/etc\/ssh\/sshd_config.d\/\*\.conf/# Include \/etc\/ssh\/sshd_config.d\/\*\.conf/' /etc/ssh/sshd_config

RUN mkdir -p /home/developer/.vscode-server/extensions \
             /root/.vscode-server/extensions

# Çalışma alanı dizini oluşturma
RUN mkdir -p /workspace && chown -R developer:developer /workspace
WORKDIR /workspace

# Container başladığında SSH servisini ön planda çalıştırıyoruz
CMD ["/usr/sbin/sshd", "-D"]
