
### Valores de VPC , SUBNET y Certificado para ALB
project_name = "test1"
environment = "qa"
health_check_path = "/users/sign_in"
subnet1 = "subnet-0b15545a362ebebef"
subnet2 = "subnet-04f51da334f825a9d"
vpc_id = "vpc-0b86cf9c2fca819e7"

##alb_tls_cert_arn = ""

##Vlores de Instancia EC2
##GITLAB-REGION DE NORTE DE CALIFORNIA
ami_id = "ami-00831fc7c1e3ddc60"   ###UBUNTU 20.04 LTS
region = "us-west-1"
instance_type = "t3.medium"
##security_group = ""
key = "glr-gitlab-qa"

##Valores para EBS
zone = "us-west-1c"
vol_root_size = "20"
vol_ebs1_size = "20"

###IP PERMITIDAS PUERTO 22
list-white = ["190.236.198.58/32","190.237.43.82/32"]


