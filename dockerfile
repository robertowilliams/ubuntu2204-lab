FROM ubuntu:22.04

# Install OpenSSH server and utilities
RUN apt-get update && apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo 'root:password' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Install additional applications
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    python3-pip \
    python3-venv \
    plocate \
    tree \
    gh \
    software-properties-common

# Install Docker
RUN curl -sSL https://get.docker.com | sh

# Expose SSH port
EXPOSE 22

# Command to keep SSH server running in the foreground
CMD ["/usr/sbin/sshd", "-D"]
