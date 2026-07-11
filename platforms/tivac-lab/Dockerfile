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
    curl \
    && rm -rf /var/lib/apt/lists/*

# SSH Yapılandırması
RUN mkdir /var/run/sshd
# Müşteri için bir kullanıcı adı ve şifre oluşturuyoruz (Örn: kullanıcı 'developer', şifre 'tiva123')
RUN useradd -rm -d /home/developer -s /bin/bash -g root -G sudo -u 1000 developer
RUN echo 'developer:tiva123' | chpasswd

# --- KRİTİK ADIM: VS Code Eklentilerini İmajın İçine Önceden Gömme ---
# VS Code Server'ın eklentileri container içinde tanıyabilmesi için global dizin oluşturuyoruz
RUN mkdir -p /home/developer/.vscode-server/extensions \
             /root/.vscode-server/extensions

WORKDIR /workspace

# Container başladığında SSH servisini arka planda değil, ön planda çalıştırıyoruz
CMD ["/usr/sbin/sshd", "-D"]
