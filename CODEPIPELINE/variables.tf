# variables de provider
variable "region" {description = "ID Region"}

# variables generales del proyecto
variable "project_name" {description = "project_name"}
variable "vpc_id" {description = "VPC ID"}
variable "environment" {description = "environment"}


variable "bucket_codepipeline_s3" {description = "bucket_codepipeline_s3"}
variable "bucket_code_s3" {description = "bucket_code_s3"}
variable "Object_code_s3" {description = "Object_code_s3"}

variable "subnet_1" {description = "subnet_1"}


