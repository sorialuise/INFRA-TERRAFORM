#!/bin/bash

sudo apt-get update >> /tmp/install.log 2>&1
sudo apt -y install awscli >> /tmp/install.log 2>&1
sudo apt-get -y install ruby-full >> /tmp/install.log 2>&1
sudo apt-get -y install wget >> /tmp/install.log 2>&1
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install >> /tmp/install.log 2>&1
chmod +x ./install >> /tmp/install.log 2>&1
sudo ./install auto >> /tmp/install.log 2>&1

#apt  -y install docker.io >> /tmp/install.log 2>&1
apt -y install nginx >> /tmp/install.log 2>&1

########
mkdir /dataweb >> /tmp/install.log 2>&1
mkdir -p /dataweb/backup >> /tmp/install.log 2>&1
mkdir -p /data/webcache/prod_cuponidad/ >> /tmp/install.log 2>&1
mv /etc/nginx/nginx.conf /etc/nginx/original-nginx.conf

#CREANDO USUARIO
adduser www2 <<EOF
EOF
#QUITAR PASSWORD:   
passwd -d www2
#AGREGAR USURIO A GRUPO
usermod -a -G www-data www2
#DAR PERMISOS DE SUDO A USUARIO www2
#sudo echo -e "www2  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sudo apt-get update

#INSTALACION DE PIP3
sudo apt -y install python3-pip >> /tmp/install.log 2>&1
#UPDATE DE PIP
python3 -m pip install --upgrade pip >> /tmp/install.log 2>&1
#INSTALACION DE ENTORNO VIRTUAL
pip3 install virtualenv >> /tmp/install.log 2>&1
#UPDATE upgrade setuptools
pip3 install --upgrade setuptools >> /tmp/install.log 2>&1
#   saber ruta devirtualenv: which virtualenv
#CREACION DE ENTORNO VIRTUAL PARA EL PROJECTO "venv/cuponidad"
virtualenv -p /usr/bin/python3 /home/www2/venv/cuponidad
chown -R www2.www2 /home/www2/venv/
#ACTIVACION DE ENTORNO VIRTUAL PARA EL PROJECTO "venv/cuponidad"
source /home/www2/venv/cuponidad/bin/activate

#INSTALACIONDE PAQUETES DE CONEXION A BASE DE DATOS MYSQL "libmariadbclient-dev"
#sudo apt-get -y install libmariadbclient-dev >> /tmp/install.log 2>&1
pip install mysqlclient >> /tmp/install.log 2>&1
#INSTALACIONDE PAQUETES DE CONEXION A BASE DE DATOS MYSQL "pip3 install mysqlclient"
pip3 install mysqlclient >> /tmp/install.log 2>&1
#INSTALACIONDE PAQUETES DE django VERSION 1.11.20
#pip3 install django==1.11.20 >> /tmp/install.log 2>&1
#INSTALACIONDE PAQUETES DE mysql-server
apt -y install mysql-server >> /tmp/install.log 2>&1

mysql <<EOF
CREATE DATABASE cuponidad;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'rootroot';
FLUSH PRIVILEGES;
exit
EOF

touch /etc/systemd/system/gunicorn-cuponidad.service
sudo echo -e "
[Unit]
Description=gunicorn cuponidad daemon
After=network.target

[Service]
User=www2
Group=www2
WorkingDirectory = /dataweb/cuponidad/cuponidad.pe
ExecStart = /home/www2/venv/cuponidad/bin/gunicorn --workers 4 -b 127.0.0.1:8080 project.wsgi:application

[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/gunicorn-cuponidad.service

#chown -R www2.www2 /home/www2/venv/
# docker pull docker.elastic.co/elasticsearch/elasticsearch:5.4.1
# docker pull docker.elastic.co/elasticsearch/elasticsearch:5.5.1

# #PASOS ADICIONALES
# #RESTORE BASE DE DATOS
# cd /dataweb/backup
# aws s3 cp s3://glr-infra/Cuponidad-files-config/DB-PROD-cuponidad-31-05-2021.sql .
# mysql --user=root --password=rootroot --host=127.0.0.1 cuponidad < DB-PROD-cuponidad-31-05-2021.sql

# #AGREGAR ARCHIVO VHOST
# cd /etc/nginx/conf.d/
# aws s3 cp s3://glr-infra/Cuponidad-files-config/cuponidad.pe.conf .
# rm -rf /etc/nginx/sites-enabled/default

# #AGREGAR ARCHIVOS DE CRONS
# cd /home/www2/
# aws s3 cp s3://glr-infra/Cuponidad-files-config/cron/ cron/ --recursive
# chown -R www2.www2 /home/www2/cron/

# #HAY que crear el CRON MANUAL EN EL USER WWW2
# #*	*	*	*	*	/home/www2/cron/sync_offers.sh
# #*	*	*	*	*	/home/www2/cron/sync_stock.sh
# #*/5     *       *       *       *       /home/www2/cron/sync_segments.sh
# #*       *       *       *       *       /home/www2/cron/sync_banners.sh
# #*/5     *       *       *       *       /home/www2/cron/sync_sorteos.sh
# #*/5     *       *       *       *       /home/www2/cron/sync_searchindex.sh

# source /home/www2/venv/cuponidad/bin/activate
# service nginx restart