#!/bin/bash

docker compose up -d && \
docker cp ./alert_rules.yml proms-1:/root/proms/alert_rules.yml && \
docker cp ./prometheus.yml proms-1:/root/proms/prometheus.yml && \
docker cp ./alertmanager.yml proms-1:/root/alerts/alertmanager.yml && \
docker exec proms-1 sh -c "nohup /root/proms/prometheus --config.file=/root/proms/prometheus.yml >/root/prometheus.log 2>&1 & nohup /root/alerts/alertmanager --config.file=/root/alerts/alertmanager.yml >/root/alertmanager.log 2>&1 &" && \
docker exec jenk-1 sh -c """
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm install node && \
    npm install --global smee-client
    smee --url https://smee.io/HjVfbSqXepu2LX --path /github-webhook/ --port 8080 &
"""
# docker exec proms-1 sh -c "nohup /root/proms/prometheus --config.file=/root/proms/prometheus.yml &"
# docker exec proms-1 sh -c "nohup /root/alerts/alertmanager --config.file=/root/alerts/alertmanager.yml &"