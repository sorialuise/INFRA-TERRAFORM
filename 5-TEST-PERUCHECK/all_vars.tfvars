
### Valores de VPC , SUBNET y Certificado para ALB
project_name = "node-test1"
environment = "qa"
health_check_path = "/backend-status"
subnet1 = "subnet-0b15545a362ebebef"
subnet2 = "subnet-04f51da334f825a9d"
vpc_id = "vpc-0b86cf9c2fca819e7"

##Valores de Instancia EC2-REGION DE NORTE DE CALIFORNIA
#ami_id = "ami-08d0eee5e00da8a9b"   ###UBUNTU 16 LTS Canonical - Varnish-4.1
ami_id = "ami-0a741b782c2c8632d"   ###UBUNTU 18 LTS Canonical - Varnish-5.2.1
region = "us-west-1"
instance_type = "t3.medium"
role = "glr-Role-S3Apps"
key = "glr-gitlab-qa"

##Valores para EBS
zone = "us-west-1c"
vol_root_size = "20"
vol_ebs1_size = "30"

###IP PERMITIDAS PUERTO 22 80 y 3000
list-white = ["190.236.198.58/32"]
