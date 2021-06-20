# variables generales del proyecto
variable "project_name" {description = "project_name"}
variable "vpc_id" {description = "VPC ID"}
variable "environment" {description = "environment"}
#variable "alb_tls_cert_arn" {description = "certificado HTTPS"}

# variables de provider
variable "region" {description = "ID Region"}

# variables de launch_configuration
variable "launch_name" {description = "Name from launch_configuration"}
variable "image_id" {description = "id Imagen"}
variable "instance_type" {description = "type instance"}
variable "ec2_key_name" {description = "key_ec2"}
variable "ebs_optimized" {description = "ebs_optimizada"}
variable "role_ec2" {description = "role_ec2"}

# variables de autoscaling_group
variable "name_asg" {description = "Name from ASG"}
variable "subnet1" {description = "subnet1"}
variable "subnet2" {description = "subnet2"}
variable "min_size" {description = "numero minimo de ec2"}
variable "max_size" {description = "numero maximo de ec2"}
variable "desired_capacity" {description = "desired_capacity"}
variable "health_check_grace_period" {description = "health_check_grace_period"}
variable "health_check_type" {description = "health_check_type"}
variable "termination_policies" {description = "termination_policies"}
variable "default_cooldown" {description = "default_cooldown"}

# variables de target_group
variable "health_check_path" {description = "health_check_path"}
variable "time_deregistration" {description = "time_deregistration of target_group"}

# variables de tags autoscaling_group
variable "tag_name" {description = "Name PROJECT-ASG"}
variable "tag_env" {description = "Name Env"}
variable "tag_desc" {description = "PROJECT AMBIENTE Autoscalling"}
variable "tag_deploy" {description = "NAME DEPLOY"}


# variables de asg_policy_1
variable "policy1_name" {description = "name_policy"}
variable "policy1_type" {description = "name_type_policy"}
variable "scaling1_adjustment" {description = "scaling_adjustment"}
variable "adjustment1_type" {description = "scaling_adjustment"}
variable "cooldown1" {description = "cooldown"}

# variables de asg_policy_2
variable "policy2_name" {description = "name_policy"}
variable "policy2_type" {description = "name_type_policy"}
variable "scaling2_adjustment" {description = "scaling_adjustment"}
variable "adjustment2_type" {description = "scaling_adjustment"}
variable "cooldown2" {description = "cooldown"}

#variables de "aws_cloudwatch_metric_alarm1" "ec2-up"
variable "alarm_name1" {description = "alarm_name"}
variable "comparison_operator1" {description = "comparison_operator"}
variable "evaluation_periods1" {description = "evaluation_periods"}
variable "metric_name1" {description = "metric_name"}
variable "namespace1" {description = "namespace"}
variable "period1" {description = "period"}
variable "statistic1" {description = "statistic"}
variable "threshold1" {description = "threshold"}

#variables de "aws_cloudwatch_metric_alarm1" "ec2-up"
variable "alarm_name2" {description = "alarm_name"}
variable "comparison_operator2" {description = "comparison_operator"}
variable "evaluation_periods2" {description = "evaluation_periods"}
variable "metric_name2" {description = "metric_name"}
variable "namespace2" {description = "namespace"}
variable "period2" {description = "period"}
variable "statistic2" {description = "statistic"}
variable "threshold2" {description = "threshold"}

#variables de "sns_topic" 
variable "topic_arn" {description = "topic_arn"}

#variables de segurity group permitidos 
variable "sg_bastion" {description = "segurity_group of bastion"}
variable "sg_jenkins" {description = "segurity_group of jenkins"}

