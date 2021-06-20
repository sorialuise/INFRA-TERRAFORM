#!/bin/bash

sudo apt-get update >> /tmp/install.log 2>&1
sudo apt -y install awscli >> /tmp/install.log 2>&1
sudo apt -y install nginx >> /tmp/install.log 2>&1
sudo apt -y install unzip

cd /etc/nginx/sites-enabled
sudo touch testpmtail.glr.pe.conf

sudo echo -e "server {
    listen 80;
    listen [::]:80;
    server_name  testpmtail.glr.pe;

    location / {
        proxy_pass           http://localhost:3000/;
    }
}" >> /etc/nginx/sites-enabled/testpmtail.glr.pe.conf

sudo service nginx restart
#sudo service nginx status

# sudo apt-get install -y apt-transport-https
# sudo apt-get install -y software-properties-common wget
# wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
# echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

# sudo apt-get update
# sudo apt-get -y install grafana

# sudo systemctl daemon-reload
# sudo systemctl start grafana-server
# #sudo systemctl status grafana-server

# sudo service nginx restart
# sudo systemctl enable grafana-server.service

# # #INSTALANDO LOKI

# # useradd -r -s /usr/sbin/nologin loki
# # wget https://github.com/grafana/loki/releases/download/v1.5.0/loki-linux-amd64.zip
# # unzip loki-linux-amd64.zip
# # mkdir /etc/loki
# # mkdir /var/lib/loki
# # cp loki-linux-amd64 /usr/local/bin/loki
# # chown loki:loki /usr/local/bin/loki
# # chown loki:loki /var/lib/loki -R

# # #Ahora creamos el fichero /etc/systemd/system/loki.service, con el siguiente contenido:

# # touch /etc/systemd/system/loki.service

# # sudo echo -e "[Unit]
# # Description=Loki Service
# # After=network-online.target
 
# # [Service]
# # ExecStart=/usr/local/bin/loki --config.file=/etc/loki/loki-config.yaml
# # User=loki        
# # Type=simple
 
# # [Install]
# # WantedBy=multi-user.target " >> /etc/systemd/system/loki.service

# # #A continuación necesitamos crear el fichero de configuración /etc/loki/loki-config.yaml:
# # touch /etc/loki/loki-config.yaml

# # sudo echo -e "auth_enabled: false
 
# # server:
# #   http_listen_port: 3100
 
# # ingester:
# #   lifecycler:
# #     address: 127.0.0.1
# #     ring:
# #       kvstore:
# #         store: inmemory
# #       replication_factor: 1
# #     final_sleep: 0s
# #   chunk_idle_period: 5m
# #   chunk_retain_period: 30s
 
# # schema_config:
# #   configs:
# #   - from: 2020-06-28
# #     store: boltdb
# #     object_store: filesystem
# #     schema: v9
# #     index:
# #       prefix: index_
# #       period: 168h
 
# # storage_config:
# #   boltdb:
# #     directory: /var/lib/loki/index
 
# #   filesystem:
# #     directory: /var/lib/loki/chunks
 
# # limits_config:
# #   enforce_metric_name: false
# #   reject_old_samples: true
# #   reject_old_samples_max_age: 168h
 
# # chunk_store_config:
# #   max_look_back_period: 0s
 
# # table_manager:
# #   chunk_tables_provisioning:
# #     inactive_read_throughput: 0
# #     inactive_write_throughput: 0
# #     provisioned_read_throughput: 0
# #     provisioned_write_throughput: 0
# #   index_tables_provisioning:
# #     inactive_read_throughput: 0
# #     inactive_write_throughput: 0
# #     provisioned_read_throughput: 0
# #     provisioned_write_throughput: 0
# #   retention_deletes_enabled: true
# #   retention_period: 672h " >> /etc/loki/loki-config.yaml



# # systemctl enable loki
# # systemctl start loki
# # systemctl status loki


# #2daFORMA
# curl -s https://api.github.com/repos/grafana/loki/releases/latest | grep browser_download_url |  cut -d '"' -f 4 | grep loki-linux-amd64.zip | wget -i -
# unzip loki-linux-amd64.zip
# sudo mv loki-linux-amd64 /usr/local/bin/loki
# sudo mkdir -p /data/loki
# sudo touch /etc/loki-local-config.yaml

# sudo echo -e "auth_enabled: false

# server:
#   http_listen_port: 3100

# ingester:
#   lifecycler:
#     address: 127.0.0.1
#     ring:
#       kvstore:
#         store: inmemory
#       replication_factor: 1
#     final_sleep: 0s
#   chunk_idle_period: 5m
#   chunk_retain_period: 30s
#   max_transfer_retries: 0

# schema_config:
#   configs:
#     - from: 2018-04-15
#       store: boltdb
#       object_store: filesystem
#       schema: v11
#       index:
#         prefix: index_
#         period: 168h

# storage_config:
#   boltdb:
#     directory: /data/loki/index

#   filesystem:
#     directory: /data/loki/chunks

# limits_config:
#   enforce_metric_name: false
#   reject_old_samples: true
#   reject_old_samples_max_age: 168h

# chunk_store_config:
#   max_look_back_period: 0s

# table_manager:
#   retention_deletes_enabled: false
#   retention_period: 0s" >> /etc/loki-local-config.yaml


# sudo tee /etc/systemd/system/loki.service<<EOF
# [Unit]
# Description=Loki service
# After=network.target

# [Service]
# Type=simple
# User=root
# ExecStart=/usr/local/bin/loki -config.file /etc/loki-local-config.yaml

# [Install]
# WantedBy=multi-user.target
# EOF

# sudo systemctl daemon-reload
# sudo systemctl start loki.service

#INSTALANDO LOKI

# curl -s https://api.github.com/repos/grafana/loki/releases/latest | grep browser_download_url |  cut -d '"' -f 4 | grep loki-linux-amd64.zip | wget -i -

# unzip loki-linux-amd64.zip
# sudo mv loki-linux-amd64 /usr/local/bin/loki

# sudo mkdir -p /data/loki

# sudo tee /etc/loki-local-config.yaml<<EOF
# auth_enabled: false

# server:
#   http_listen_port: 3100

# ingester:
#   lifecycler:
#     address: 127.0.0.1
#     ring:
#       kvstore:
#         store: inmemory
#       replication_factor: 1
#     final_sleep: 0s
#   chunk_idle_period: 5m
#   chunk_retain_period: 30s
#   max_transfer_retries: 0

# schema_config:
#   configs:
#     - from: 2018-04-15
#       store: boltdb
#       object_store: filesystem
#       schema: v11
#       index:
#         prefix: index_
#         period: 168h

# storage_config:
#   boltdb:
#     directory: /data/loki/index

#   filesystem:
#     directory: /data/loki/chunks

# limits_config:
#   enforce_metric_name: false
#   reject_old_samples: true
#   reject_old_samples_max_age: 168h

# chunk_store_config:
#   max_look_back_period: 0s

# table_manager:
#   retention_deletes_enabled: false
#   retention_period: 0s
# EOF

# sudo tee /etc/systemd/system/loki.service<<EOF
# [Unit]
# Description=Loki service
# After=network.target

# [Service]
# Type=simple
# User=root
# ExecStart=/usr/local/bin/loki -config.file /etc/loki-local-config.yaml

# [Install]
# WantedBy=multi-user.target
# EOF

# sudo systemctl daemon-reload
# sudo systemctl start loki.service

#INSTALANDO PROMTAIL
curl -s https://api.github.com/repos/grafana/loki/releases/latest | grep browser_download_url |  cut -d '"' -f 4 | grep promtail-linux-amd64.zip | wget -i -

unzip promtail-linux-amd64.zip
sudo mv promtail-linux-amd64 /usr/local/bin/promtail

sudo tee /etc/promtail-local-config.yaml<<EOF
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /data/loki/positions.yaml

clients:
  - url: http://localhost:3100/loki/api/v1/push

scrape_configs:
- job_name: system
  static_configs:
  - targets:
      - localhost
    labels:
      job: varlogs
      __path__: /var/log/*log
EOF

sudo tee /etc/systemd/system/promtail.service<<EOF
[Unit]
Description=Promtail service
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/promtail -config.file /etc/promtail-local-config.yaml

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start promtail.service
