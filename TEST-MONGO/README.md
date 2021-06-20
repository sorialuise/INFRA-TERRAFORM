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
terraform plan -var-file all_vars.tfvars
terraform apply -var-file all_vars.tfvars -auto-approve
terraform destroy -var-file all_vars.tfvars -auto-approve

