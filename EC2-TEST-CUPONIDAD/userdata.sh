#!/bin/bash

sudo apt-get update >> /tmp/install.log 2>&1
sudo apt -y install awscli >> /tmp/install.log 2>&1
sudo apt-get -y install ruby-full >> /tmp/install.log 2>&1
sudo apt-get -y install wget >> /tmp/install.log 2>&1
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install >> /tmp/install.log 2>&1
chmod +x ./install >> /tmp/install.log 2>&1
sudo ./install auto >> /tmp/install.log 2>&1

apt  -y install docker.io >> /tmp/install.log 2>&1
apt -y install nginx >> /tmp/install.log 2>&1

########
mkdir /dataweb >> /tmp/install.log 2>&1
mkdir -p /data/webcache/prod_cuponidad/ >> /tmp/install.log 2>&1
mv /etc/nginx/nginx.conf /etc/nginx/original-nginx.conf
#chown -R 1001:www2 /dataweb/

#CREANDO USUARIO
adduser www2 <<EOF
EOF
#QUITAR PASSWORD:   
passwd -d www2
#AGREGAR USURIO A GRUPO
usermod -a -G www-data www2
#DAR PERMISOS DE SUDO A USUARIO www2
sudo echo -e "www2  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sudo apt-get update
#   sudo apt -y install mysql-server
#   saber ruta de python: which python3
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
#ACTIVACION DE ENTORNO VIRTUAL PARA EL PROJECTO "venv/cuponidad"
source /home/www2/venv/cuponidad/bin/activate
#   sudo apt-get install python3-dev default-libmysqlclient-dev build-essential
#   pip3 install Django
#   source venv/cuponidad/bin/activate
#   pip install django
#INSTALACIONDE PAQUETES DE CONEXION A BASE DE DATOS MYSQL "libmariadbclient-dev"
sudo apt-get -y install libmariadbclient-dev >> /tmp/install.log 2>&1
#   pip install mysqlclient
#INSTALACIONDE PAQUETES DE CONEXION A BASE DE DATOS MYSQL "pip3 install mysqlclient"
pip3 install mysqlclient >> /tmp/install.log 2>&1
#INSTALACIONDE PAQUETES DE django VERSION 1.11.20
pip3 install django==1.11.20 >> /tmp/install.log 2>&1
#INSTALACIONDE PAQUETES DE mysql-server
apt -y install mysql-server >> /tmp/install.log 2>&1
#   mysql> select User from mysql.user;
#   mysql> USE mysql;
#   mysql> SELECT User, Host, plugin FROM mysql.user;
#   chown -R www2.www2 venv/
#   sudo mysql -u root -p
    
    #mysql
   #mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'rootroot';
   #FLUSH PRIVILEGES;
   #CREATE DATABASE cuponidad;

mysql <<EOF
CREATE DATABASE cuponidad;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'rootroot';
FLUSH PRIVILEGES;
exit
EOF

#   sudo pip3 install elasticsearch
#   service mysql restart
#   no funciono:
#   UPDATE user SET plugin='mysql_native_password' WHERE User='root';
#   apt install gunicorn
#   pip3 install gunicorn
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

chown -R www2.www2 /home/www2/venv/
docker pull docker.elastic.co/elasticsearch/elasticsearch:5.4.1
docker pull docker.elastic.co/elasticsearch/elasticsearch:5.5.1
