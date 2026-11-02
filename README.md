# Local DevOps Sandbox for Monitoring & Alerting

## Introduction
This project implements an all-in-one DevOps monitoring environment on an Ubuntu AWS EC2 instance.

## Objectives
- Monitor CPU, memory and disk usage.
- Collect system metrics using Node Exporter.
- Visualize metrics using Grafana.
- Configure alerts using Prometheus.
- Manage alerts using Alertmanager.

## Tools Used
- AWS EC2
- Ubuntu 24.04
- Prometheus
- Grafana
- Node Exporter
- Alertmanager
- Bash
- Git and GitHub

## Architecture
Ubuntu EC2 Instance
  |
  |-- Node Exporter
  |-- Prometheus
  |-- Grafana
  |-- Alertmanager

## Implementation
1. Created an Ubuntu EC2 instance.
2. Installed Prometheus and Node Exporter.
3. Installed Grafana and configured Prometheus as a data source.
4. Imported the Node Exporter Full dashboard.
5. Created CPU, disk and target availability alert rules.
6. Installed and configured Alertmanager.
7. Tested alert reception using amtool.

## Validation
- Prometheus targets verified as UP.
- Prometheus alert rules validated.
- Grafana dashboard displaying system metrics.
- Alertmanager test alert successfully received and resolved.
- All four monitoring services verified as active.

## Access
- Grafana: http://32.196.165.27:3000
- Prometheus: http://32.196.165.27:9090

Restrict access to trusted IP addresses using AWS Security Groups.

## Conclusion
Successfully implemented a centralized monitoring and alerting sandbox using open-source DevOps tools on AWS EC2.
