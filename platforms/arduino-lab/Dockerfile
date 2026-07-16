FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    gcc-avr \
    binutils-avr \
    avr-libc \
    gdb-avr \
    avrdude \
    simavr \
    make \
    iproute2 \
    openssh-server \
    sudo \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

RUN useradd -m -s /bin/bash -G sudo developer && \
    echo "developer:ardu123" | chpasswd

RUN echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p /home/developer/.vscode-server/extensions \
             /root/.vscode-server/extensions && \
    chown -R developer:developer /home/developer

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/Include \/etc\/ssh\/sshd_config.d\/\*\.conf/# Include \/etc\/ssh\/sshd_config.d\/\*\.conf/' /etc/ssh/sshd_config

RUN mkdir -p /workspace && chown -R developer:developer /workspace
WORKDIR /workspace

CMD ["/usr/sbin/sshd", "-D"]
