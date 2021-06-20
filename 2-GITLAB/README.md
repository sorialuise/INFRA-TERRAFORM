# Comando para crear llave publica y privada "pem":
    ssh-keygen -m pem -b 4096 -f class_key1.pem

# Comando para comprobar que la infraestructura no tenga errores:
    terraform plan

# Comando para construir la infraestructura:
    terraflorm apply -auto-approve

# Comando para destruir la infraestructura:
    terraform destroy -auto-approve

# Comando para poner en comentarios las lineas seleccionadas:
    Control + Shift + 7

# Comando para leer archivo de variables "all_vars.tfvars"
    terraform plan -var-file all_vars.tfvars

# Comando para aplicar el archivo de variables "all_vars.tfvars"
    terraform apply -var-file all_vars.tfvars -auto-approve

# Comando para destruir infra con archivo de variables "all_vars.tfvars"
    terraform destroy -var-file all_vars.tfvars -auto-approve

# Comando para mostrar grafia via navegador usando paquete "graphviz"
    terraform graph | dot -Tsvg > graph.svg

####
terraform init
terraform plan -var-file all_vars.tfvars
terraform apply -var-file all_vars.tfvars -auto-approve
terraform destroy -var-file all_vars.tfvars -auto-approve

# Comandos Gitlab
## version de Gitlab
sudo gitlab-rake gitlab:env:info

# actualizar gitlab

apt-get update
apt-get install gitlab-ce=<YOUR-LATEST-MINOR-VERSION>-ce.0
gitlab-ctl reconfigure
gitlab-ctl restart



12.7.5 -> 12.10.5
11.3.4 -> 11.11.1
10.6.6 -> 10.8.3
11.3.4 -> 11.11.8
10.6.6 -> 10.8.7
9.2.3 -> 9.5.5
8.9.4 -> 8.12.3 
apt-get install gitlab-ce=10.8.3-ce.0


apt-get install gitlab-ce=12.3.0-ce.0
 
  vim /etc/gitlab/gitlab.rb 
  gitlab-ctl reconfigure
  gitlab-ctl restart
  gitlab-rake gitlab:env:info

apt-get install gitlab-ce=12.8.0-ce.0

12.8.0

solucionar error: <PUBKEY> se reemplaza por key faltante
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3F01618A51312F3F

12.9.2 > 12.9.3 > 12.9.10 > 12.10.14 > 13.0.0 > 13.1.11 > 13.2.10 
> 13.3.9 > 13.5.0 > 

#show version SO ubuntu
lsb_release -a

RUTAS de CONFIG VARNISH UBUNTU
vim /etc/default/varnish
vim /etc/varnish/default.vcl
vim /lib/systemd/system/varnish.service

####### Instalacion de nginx

####### Instalacion de varnish
sudo apt-get update
sudo apt-get install debian-archive-keyring
sudo apt-get install curl gnupg apt-transport-https
curl -L https://packagecloud.io/varnishcache/varnish41/gpgkey | sudo apt-key add -

touch /etc/apt/sources.list.d/varnishcache_varnish41.list

sudo echo -e "deb https://packagecloud.io/varnishcache/varnish41/ubuntu/ xenial main
deb-src https://packagecloud.io/varnishcache/varnish41/ubuntu/ xenial main" >> /etc/apt/sources.list.d/varnishcache_varnish41.list

sudo apt-get update