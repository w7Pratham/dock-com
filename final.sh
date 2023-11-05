#!/bin/bash

docker compose up -d && \
docker cp ./alert_rules.yml proms-1:/root/proms/alert_rules.yml && \
docker cp ./prometheus.yml proms-1:/root/proms/prometheus.yml && \
docker cp ./alertmanager.yml proms-1:/root/alerts/alertmanager.yml && \
docker exec proms-1 sh -c "/root/proms/prometheus --config.file=/root/proms/prometheus.yml && /root/alerts/alertmanager --config.file=/root/alerts/alertmanager.yml"