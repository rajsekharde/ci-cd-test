#!/usr/bin/env bash

# How to run:
# Copy this file to an ubuntu machine using scp
# Change file permissions to make it executable: chmod +x ec2-setup.sh
# Run the script: sudo ./ec2-setup.sh
# Once script execution completes, reboot the system
# Check installed packages: git --version, docker --version, docker compose version
# Run the docker container: docker run hello-world

set -euo pipefail

TARGET_USER="${SUDO_USER:-$USER}"

printf "\nUpdating & upgrading packages\n\n"
apt update
apt upgrade -y

printf "\nInstalling Git\n\n"
apt install -y git

printf "\nInstalling Docker\n\n"
apt install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable docker
systemctl start docker
usermod -aG docker "$TARGET_USER"

printf "\nInstallation done.. Reboot the system\n\n"
