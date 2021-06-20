### Indicaciones
# La siguente plantilla crea los siguientes recusos.
1 Aplications load_balancer
1 Segurity_Group - Aplications load_balancer
1 Target_Group
1 Launch_Configuration
1 Autoscalng_Group:
    - Policita de autoscaling UP
    - Policita de autoscaling DOWN
    - Alarma de Cloudwhach ASG UP
    - Alarma de Cloudwhach ASG DOWN
1 Segurity_Group - EC2 que será usado en el Launch_Configuration

# La siguente plantilla llama a los siguientes valores, que deben existir previamente.

1 vpc_id
1 region
1 alb_tls_cert_arn (Certificado HTTPS)
1 image_id 
1 ec2_key_name  (llave de instacia ec2)
1 role_ec2      (rol de instacia ec2)
2 subnet1 , subnet2  (2 subnets de la VPC)                     
1 health_check_path  ("Path de salud definido en varnish")
1 topic_arn  (ARN del SNS usado por la alarma de Cloudwhach para la notificación)


# Comandos para ejecutar la Plantilla
terraform init                                                      (Debe ejecurarse la primera vez para descargar los plugins de Terraform)
terraform plan -var-file all_vars.tfvars                            (Se ejecuta para validar la Sintaxis)
terraform apply -var-file all_vars.tfvars -auto-approve             (Se ejecuta para crear los recusos)
terraform destroy -var-file all_vars.tfvars -auto-approve           (Se ejecuta para destruir los recusos)

