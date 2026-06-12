#!/usr/bin/env bash
set -euo pipefail

if [ ! -f /etc/os-release ]; then
  echo "Unsupported OS (no /etc/os-release). Install Grafana manually." >&2
  exit 1
fi

. /etc/os-release
if echo "$ID $ID_LIKE" | grep -Eqi "debian|ubuntu"; then
  echo "Installing Grafana (Debian/Ubuntu) via official repo"
  sudo apt-get install -y apt-transport-https software-properties-common wget
  wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
  echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
  sudo apt-get update
  sudo apt-get install -y grafana
  sudo systemctl enable --now grafana-server
  echo "Grafana installed and started (http://localhost:3000). Default admin/admin"
else
  echo "Please install Grafana using your distro's package manager or from https://grafana.com/grafana/download" >&2
fi
