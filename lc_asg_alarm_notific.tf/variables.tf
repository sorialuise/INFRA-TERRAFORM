# variables de provider
variable "region" {description = "Region"}

# variables de launch_configuration
variable "lc_name" {description = "launch_configuration"}
variable "image_id" {description = "id de Imagen"}
variable "instance_type" {description = "type instance"}
variable "ec2_key_name" {description = "key_ec2"}
variable "sg" {description = "Security_Group"}
variable "ebs_optimized" {description = "ebs_optimizada"}
variable "role_ec2" {description = "role_ec2"}

# variables de autoscaling_group
variable "name_asg" {description = "Name from ASG"}
#variable "name_launch_config" {description = "Name from launch_configuration"}
#variable "vpc_zone_identifier" {description = "vpc_zone_identifier"}
variable "subnet1" {description = "subnet1"}
variable "subnet2" {description = "subnet2"}
variable "min_size" {description = "numero minimo de ec2"}
variable "max_size" {description = "numero maximo de ec2"}
variable "desired_capacity" {description = "desired_capacity"}
variable "health_check_grace_period" {description = "health_check_grace_period"}
variable "health_check_type" {description = "health_check_type"}
variable "termination_policies" {description = "termination_policies"}
variable "target_group_arns" {description = "target_group_arns"}
variable "default_cooldown" {description = "default_cooldown"}

# variables de tags autoscaling_group
variable "tag_key1" {description = "Name"}
variable "tag_value1" {description = "CRONOS-ADMIN-ASG"}
variable "tag_key2" {description = "Amb"}
variable "tag_value2" {description = "Prod"}
variable "tag_key3" {description = "Desc"}
variable "tag_value3" {description = "Cronos ADMIN PROD Autoscalling"}


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