FROM ubuntu:jammy
LABEL maintainer = "Nurul Amin Muhit <me@muhit.me>"

# Install SSH, sudo, and basic tools
RUN apt-get update && \
    apt-get install -y openssh-server sudo curl && \
    apt-get install -y vim net-tools iproute2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd

# Create a non-root user (like vagrant)
# -m: create home directory: /home/docker
# -s: sets default login shell: /bin/bash
RUN useradd -m -s /bin/bash docker && \
    echo 'docker:password' | chpasswd && \
    adduser docker sudo

# Enable password and key-based authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# Accept build argument for node type (default: master)
ARG VM_NODE_TYPE=master

# Setup SSH keys for docker user and fix permissions
RUN mkdir -p /home/docker/.ssh
COPY keys/id_rsa_${VM_NODE_TYPE}.pub /home/docker/.ssh/authorized_keys
RUN chown -R docker:docker /home/docker/.ssh && \
    chmod 700 /home/docker/.ssh && \
    chmod 600 /home/docker/.ssh/authorized_keys

# Expose SSH port
EXPOSE 22

# Start sshd in foreground
CMD ["/usr/sbin/sshd", "-D"]
