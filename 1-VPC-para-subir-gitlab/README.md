# Comandos para ejecutar la Plantilla
terraform init                                                      (Debe ejecurarse la primera vez para descargar los plugins de Terraform)
terraform plan -var-file all_vars.tfvars                            (Se ejecuta para validar la Sintaxis)
terraform apply -var-file all_vars.tfvars -auto-approve             (Se ejecuta para crear los recusos)
terraform destroy -var-file all_vars.tfvars -auto-approve           (Se ejecuta para destruir los recusos)

