
# variable "ami_id" {
#   description = "ID AMI"
# }


variable "region" {
    description = "ID REGION"
}


# variable "vpc_cidr" {
#     description = "VPC Cidr"
# }

# variable "subnet1_cidr" {
#     description = "Subnet1 cidr"
# }

# variable "subnet2_cidr" {
#     description = "Subnet2 cidr"
# }
# variable "subnet1_zone_1b" {
#     description = "Zone 1b - Subnet 1"
# }
# variable "subnet2_zone_1c" {
#     description = "Zone 1c - Subnet 2"
# }

variable "vpc_cidr" {
  description = "vpc_cidr"
}

variable "environment" {
  description = "environment"
}

variable "public_subnets_cidr" {
    type = list
  description = "public_subnets_cidr"
}

variable "private_subnets_cidr" {
    type = list
  description = "private_subnets_cidr"
}

variable "availability_zones" {
    type = list
  description = "availability_zones"
}



