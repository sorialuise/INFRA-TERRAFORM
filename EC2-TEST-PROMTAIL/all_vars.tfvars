##Project-REGION DE VIRGINIA 
region = "us-east-1"
subnet1 = "subnet-0c04bc61"
subnet2 = "subnet-cbf74ca6"
vpc_id = "vpc-860ae3eb"

sg_bastion = "sg-a9c71ad1"

ami_id = "ami-0747bdcabd34c712a"   ###UBUNTU 18.04
instance_type = "t3.micro"
key = "glr-cronos"
role = "glr-Role-S3Apps"

project_name = "testpmtail"
environment = "qa"

# valor de variables target_group
health_check_path = "/"
time_deregistration = "150"

alb_tls_cert_arn = "arn:aws:acm:us-east-1:543745842878:certificate/f1e50cc4-4e7f-447a-96b8-87cd893eec4d"
