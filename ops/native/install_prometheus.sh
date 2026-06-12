#!/usr/bin/env bash
set -euo pipefail

PROM_VERSION=${PROM_VERSION:-"2.45.0"}
INSTALL_DIR=${INSTALL_DIR:-/opt/prometheus}
CONFIG_SRC="$(pwd)/ops/prometheus/prometheus.yml"

if [ ! -f /etc/os-release ]; then
  echo "Unsupported OS (no /etc/os-release). Install Prometheus manually." >&2
  exit 1
fi

. /etc/os-release
if ! echo "$ID $ID_LIKE" | grep -Eqi "debian|ubuntu|linux"; then
  echo "This installer currently targets Debian/Ubuntu or compatible systems. If you have another distro, install Prometheus manually." >&2
fi

echo "Installing Prometheus $PROM_VERSION to $INSTALL_DIR"
sudo useradd --system --no-create-home --shell /usr/sbin/nologin prometheus || true
sudo mkdir -p "$INSTALL_DIR"
sudo chown prometheus:prometheus "$INSTALL_DIR"

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT
ARCH=linux-amd64
TARFILE="prometheus-${PROM_VERSION}.${ARCH}.tar.gz"
URL="https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/${TARFILE}"

echo "Downloading $URL"
curl -fsSL -o "$TMPDIR/$TARFILE" "$URL"
tar -xzf "$TMPDIR/$TARFILE" -C "$TMPDIR"
EXTRACTED="$TMPDIR/prometheus-${PROM_VERSION}.${ARCH}"

sudo cp -r "$EXTRACTED"/* "$INSTALL_DIR/"
sudo chown -R prometheus:prometheus "$INSTALL_DIR"

sudo mkdir -p /etc/prometheus
if [ -f "$CONFIG_SRC" ]; then
  sudo cp "$CONFIG_SRC" /etc/prometheus/prometheus.yml
else
  echo "Warning: repo prometheus config not found at $CONFIG_SRC; please place a config at /etc/prometheus/prometheus.yml" >&2
fi
sudo chown -R prometheus:prometheus /etc/prometheus

echo "Installing systemd unit to /etc/systemd/system/prometheus.service"
sudo tee /etc/systemd/system/prometheus.service > /dev/null <<'EOF'
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/opt/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo mkdir -p /var/lib/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
sudo systemctl daemon-reload
sudo systemctl enable --now prometheus

echo "Prometheus installed and started. Check status: sudo systemctl status prometheus"
