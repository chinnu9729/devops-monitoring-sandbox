#!/bin/bash
set -euo pipefail

echo "Starting DevOps Monitoring Sandbox installation..."

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "Installing prerequisites..."
apt-get update
apt-get install -y wget curl gnupg ca-certificates

echo "Adding Grafana repository..."
mkdir -p /etc/apt/keyrings
wget -q -O - https://apt.grafana.com/gpg.key | \
    gpg --dearmor --yes -o /etc/apt/keyrings/grafana.gpg

echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" \
    > /etc/apt/sources.list.d/grafana.list

apt-get update

echo "Installing monitoring tools..."
apt-get install -y prometheus prometheus-node-exporter \
    prometheus-alertmanager grafana

echo "Copying Prometheus configuration..."
cp "$PROJECT_DIR/prometheus/prometheus.yml" /etc/prometheus/prometheus.yml
cp "$PROJECT_DIR/prometheus/alert.rules.yml" /etc/prometheus/alert.rules.yml
cp "$PROJECT_DIR/alertmanager/alertmanager.yml" /etc/prometheus/alertmanager.yml

echo "Validating configurations..."
promtool check config /etc/prometheus/prometheus.yml
promtool check rules /etc/prometheus/alert.rules.yml
amtool check-config /etc/prometheus/alertmanager.yml

echo "Enabling monitoring services..."
systemctl enable prometheus prometheus-node-exporter
systemctl enable prometheus-alertmanager grafana-server

systemctl restart prometheus
systemctl restart prometheus-node-exporter
systemctl restart prometheus-alertmanager
systemctl restart grafana-server

echo "Checking service status..."
systemctl is-active prometheus
systemctl is-active prometheus-node-exporter
systemctl is-active prometheus-alertmanager
systemctl is-active grafana-server

echo "Monitoring Sandbox installation completed successfully!"
