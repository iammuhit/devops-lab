FROM ubuntu:jammy
LABEL maintainer = "Nurul Amin Muhit <me@muhit.me>"

# Install SSH, sudo, and basic tools
RUN apt-get update && \
    apt-get install -y openssh-server sudo curl && \
    apt-get install -y vim net-tools iproute2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd

# Set root password and configure SSH
RUN echo 'root:root' | chpasswd

# Enable password and key-based authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# Set up SSH keys for root user
RUN mkdir -p /home/root/.ssh
COPY keys/id_rsa.pub /home/root/.ssh/authorized_keys
RUN chmod 700 /home/root/.ssh && chmod 600 /home/root/.ssh/authorized_keys

# Expose SSH port
EXPOSE 22

# Start sshd in foreground
CMD ["/usr/sbin/sshd", "-D"]
