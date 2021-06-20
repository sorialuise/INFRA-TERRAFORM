
variable "region" {
    description = "ID REGION"
}

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



