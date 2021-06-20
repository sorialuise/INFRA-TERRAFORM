
### Comandos Terraform
## para iniciar el proyecto:
terraform init
## para validar sintaxis:
terraform plan -var-file all_vars.tfvars
## para construir:
terraform apply -var-file all_vars.tfvars -auto-approve
## para destruir:
terraform destroy -var-file all_vars.tfvars -auto-approve



