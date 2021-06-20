
### Valores generales del proyecto
project_name = "perucheck"
environment = "prod"
vpc_id = "vpc-0b86cf9c2fca819e7"
region = "us-west-1"
alb_tls_cert_arn = "arn:aws:acm:us-west-1:543745842878:certificate/375fe6d5-fbdd-4293-b75d-28ebd1c52f3f"

###IP PERMITIDAS PUERTO 22 80 y 3000
list-white = ["190.236.198.58/32"]

# valor de variables launch_configuration
launch_name   = "glr-launchconfiguration-PROD-PeruCheck"
image_id      = "ami-04d7c565de3406783"
instance_type = "t3.medium"
ebs_optimized = "true"
ec2_key_name  = "glr-gitlab-qa"
role_ec2      = "glr-Role-S3Apps"

# valor de variables autoscaling_group
name_asg = "glr-vpc1-AutoScaling-PROD-PeruCheck"
min_size                  = 1
max_size                  = 1
desired_capacity          = 1
subnet1                   = "subnet-00679ca9378e9afd0"
subnet2                   = "subnet-0b15545a362ebebef"
health_check_grace_period = 60
health_check_type         = "ELB"
termination_policies      = ["NewestInstance"]
default_cooldown          = 60

# valor de variables target_group
health_check_path = "/backend-status"
time_deregistration = "150"

# valor de variables tags autoscaling_group
tag_name = "PERUCHECK-PROD-ASG"
tag_env = "Prod"
tag_desc = "PERUCHECK PROD Autoscalling"
tag_deploy = "PERUCHECK-PROD-ASG"


# valores variables de asg_policy1
policy1_name        = "Instance-UP"
policy1_type        = "SimpleScaling"
scaling1_adjustment = 1
adjustment1_type    = "ChangeInCapacity"
cooldown1           = 60

# valores variables de asg_policy2
policy2_name        = "Instance-DOWN"
policy2_type        = "SimpleScaling"
scaling2_adjustment = -1
adjustment2_type    = "ChangeInCapacity"
cooldown2           = 60

# valores variables de "aws_cloudwatch_metric_alarm1" "ec2-up"
alarm_name1          = "awsec2-glr-vpc1-AutoScaling-PROD-PERUCHECK-CPU-HIGH-Increase"
comparison_operator1 = "GreaterThanOrEqualToThreshold"
evaluation_periods1  = "1"
metric_name1         = "CPUUtilization"
namespace1           = "AWS/EC2"
period1              = "300"
statistic1           = "Average"
threshold1           = "60"

# valores variables de "aws_cloudwatch_metric_alarm2" "ec2-down"
alarm_name2          = "awsec2-glr-vpc1-AutoScaling-PROD-PERUCHECK-CPU-DOWN-Decrese"
comparison_operator2 = "LessThanOrEqualToThreshold"
evaluation_periods2   = "1"
metric_name2         = "CPUUtilization"
namespace2           = "AWS/EC2"
period2              = "300"
statistic2           = "Average"
threshold2           = 15

#valor de "sns_topic"
topic_arn = "arn:aws:sns:us-west-1:543745842878:Alarma-CN"