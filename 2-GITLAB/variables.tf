
variable "ami_id" {
  description = "ID AMI"
}

variable "region" {
    description = "ID REGION"
}

variable "instance_type" {
    description = "instance_type"
}


variable "subnet1" {
  description = "subnet1 id" 
}

variable "subnet2" {
  description = "subnet2 id" 
}

# variable "security_group" {
#     description = "security_group"  
# }

variable "key" {
    description = "value-Key1"  
}

variable "project_name" {
    description = "project_name"  
}

variable "vpc_id" {
    description = "VPC Cidr"  
}

variable "environment" {
  description = "environment" 
}

variable "health_check_path" {
  description = "health_check_path" 
}

variable "zone" {
  description = "availability_zone" 
}

variable "vol_root_size" {
  description = "vol_root_size" 
}

variable "vol_ebs1_size" {
  description = "vol_ebs1_size" 
}

variable "list-white" {
  type = list
  description = "Lista de IP's Permitidas"    
}

# variable "subnet1_cidr" {
#     description = "Subnet1 cidr"
#     #default = "10.0.1.0/24" 
# }

# variable "subnet2_cidr" {
#     description = "Subnet2 cidr"
#     #default = "10.0.2.0/24"
# }

# variable "subnet3_cidr" {
#     description = "Subnet3 cidr"
#     #default = "10.0.3.0/24" 
# }

# variable "subnet1_zone_1a" {
#     description = "Zone 1a - Subnet 1"
#     #default = "us-east-1a"
# }

# variable "subnet2_zone_1b" {
#     description = "Zone 1b - Subnet 2"
#     #default = "us-east-1b"
# }

# variable "subnet3_zone_1c" {
#     description = "Zone 1c - Subnet 3"
#     #default = "us-east-1c"
# }

# # variable "private_ip_ec2_1_Subnet1" {
# #     description = "IP Private EC2-1 Subnet 1"
    
# # }

# variable "private_ip_ec2_1_Subnet1" {
#     description = "Lista de IP's Private EC2-1 Subnet 1"
#     type = list
#     default = ["10.0.1.11","10.0.1.12","10.0.1.13"]
    
# }
