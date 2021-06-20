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


HTTP	TCP	80	190.236.198.58/32	-
SSH	TCP	22	190.236.198.58/32	-
SSH	TCP	22	190.237.43.82/32	antonio
HTTPS	TCP	443	190.236.198.58/32	-