FROM ubuntu:jammy
LABEL maintainer="Nurul Amin Muhit <me@muhit.me>"

# Install SSH, sudo, and basic tools
RUN apt-get update && \
    apt-get install -y openssh-server sudo curl && \
    apt-get install -y vim net-tools iproute2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    mkdir /var/run/sshd

# Read secrets securely (if provided) and fall back otherwise
ARG VM_USER=docker
ARG VM_PASS=password

RUN --mount=type=secret,id=ssh_username \
    --mount=type=secret,id=ssh_password \
    VM_USER=$(cat /run/secrets/ssh_username 2>/dev/null || echo "${VM_USER}") && \
    VM_PASS=$(cat /run/secrets/ssh_password 2>/dev/null || echo "${VM_USER}")

# Create a non-root user (like vagrant)
# -m: create home directory: /home/docker
# -s: sets default login shell: /bin/bash
RUN useradd -m -s /bin/bash ${VM_USER} && \
    echo "${VM_USER}:${VM_PASS}" | chpasswd && \
    adduser ${VM_USER} sudo

# Enable password and key-based authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# Accept build argument for node type (default: master)
ARG VM_NODE_TYPE=master

# Setup SSH keys for docker user and fix permissions
RUN mkdir -p /home/${VM_USER}/.ssh
COPY keys/id_rsa_${VM_NODE_TYPE}.pub /home/${VM_USER}/.ssh/authorized_keys
RUN chown -R ${VM_USER}:${VM_USER} /home/${VM_USER}/.ssh && \
    chmod 700 /home/${VM_USER}/.ssh && \
    chmod 600 /home/${VM_USER}/.ssh/authorized_keys

# Expose SSH port
EXPOSE 22

# Start sshd in foreground
CMD ["/usr/sbin/sshd", "-D"]
