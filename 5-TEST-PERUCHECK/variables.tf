
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

variable "role" {
  description = "Role EC2"    
}