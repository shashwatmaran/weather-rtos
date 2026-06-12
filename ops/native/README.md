Native install helpers

These scripts help install Prometheus and Grafana natively on Debian/Ubuntu hosts.

Scripts:
- `install_prometheus.sh` — downloads Prometheus binary, installs to `/opt/prometheus`, places config in `/etc/prometheus/prometheus.yml`, and creates a `prometheus` systemd service.
- `install_grafana.sh` — installs Grafana via the official apt repository and starts the `grafana-server` service.

Usage (run as a regular user; scripts use sudo where needed):

```bash
./ops/native/install_prometheus.sh
./ops/native/install_grafana.sh
```

After installation:
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000 (default admin/admin)

If your OS is not Debian/Ubuntu, follow the upstream installation instructions:
- Prometheus: https://prometheus.io/docs/prometheus/latest/installation/
- Grafana: https://grafana.com/docs/grafana/latest/installation/
