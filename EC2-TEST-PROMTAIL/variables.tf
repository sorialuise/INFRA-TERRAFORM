


variable "region" {description = "ID REGION"}
variable "subnet1" {description = "Subnet1 id"}
variable "subnet2" {description = "Subnet2 id"}
variable "vpc_id" {description = "vpc_id"}


variable "ami_id" {description = "ID AMI"}
variable "instance_type" {description = "instance_type"}
#variable "security_group" {description = "security_group"}
variable "key" {description = "value-Key1"}
variable "role" {description = "role"}

variable "project_name" {description = "project_name"}
variable "environment" {description = "environment"}

# variables de target_group
variable "health_check_path" {description = "health_check_path"}
variable "time_deregistration" {description = "time_deregistration of target_group"}

variable "alb_tls_cert_arn" {description = "arn-certificado-ssl"}

variable "sg_bastion" {description = "grupo de seguridad bastion"}