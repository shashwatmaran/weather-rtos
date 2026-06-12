#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "This script will install Docker & Docker Compose (if needed) and bring up the demo stack."
echo "It requires sudo for package installation and enabling services."

if command -v docker >/dev/null 2>&1; then
  echo "Docker already installed: $(docker --version)"
else
  echo "Docker not found. Detecting OS to install Docker..."
  . /etc/os-release || true
  ID_LIKE=${ID_LIKE:-}
  ID=${ID:-}

  if echo "$ID $ID_LIKE" | grep -Eqi "debian|ubuntu"; then
    echo "Installing Docker on Debian/Ubuntu..."
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo systemctl enable --now docker

  elif echo "$ID $ID_LIKE" | grep -Eqi "fedora|rhel|centos"; then
    echo "Installing Docker on Fedora/RHEL/CentOS..."
    sudo dnf -y install dnf-plugins-core
    sudo dnf -y config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo systemctl enable --now docker

  elif echo "$ID $ID_LIKE" | grep -Eqi "arch"; then
    echo "Installing Docker on Arch Linux..."
    sudo pacman -Sy --noconfirm docker docker-compose
    sudo systemctl enable --now docker

  else
    echo "Unsupported or undetected distro. Falling back to Docker convenience script." >&2
    echo "This will run an external script from get.docker.com with sudo." >&2
    read -p "Proceed? [y/N] " yn
    case "$yn" in
      [Yy]*) curl -fsSL https://get.docker.com | sudo sh ;;
      *) echo "Aborting."; exit 1 ;;
    esac
  fi
fi

echo "Ensuring current user can run Docker without sudo (optional)."
if groups $USER | grep -q docker; then
  echo "User $USER is already in the docker group."
else
  echo "Adding $USER to docker group (you may need to re-login for it to take effect)."
  sudo usermod -aG docker $USER || true
fi

echo "Launching demo stack with Docker Compose..."
cd "$REPO_ROOT/ops/docker"

if docker compose version >/dev/null 2>&1; then
  DC_CMD=(docker compose)
elif command -v docker-compose >/dev/null 2>&1; then
  DC_CMD=(docker-compose)
else
  echo "Docker Compose not found. Attempting to install docker-compose-plugin..."
  sudo apt-get update || true
  sudo apt-get install -y docker-compose-plugin || true
  if docker compose version >/dev/null 2>&1; then
    DC_CMD=(docker compose)
  else
    echo "docker compose still unavailable. Please install Docker Compose manually." >&2
    exit 1
  fi
fi

echo "Running: ${DC_CMD[*]} up --build"
sudo ${DC_CMD[*]} up --build
