# valor de variables provider
region = "us-east-1"

# valor de variables launch_configuration
lc_name       = "glr-launchconfiguration-Prod-Cronos-Admin"
image_id      = "ami-0d5da1abecae85346"
instance_type = "t3.medium"
ebs_optimized = "true"
ec2_key_name  = "glr-cronos"
sg            = "sg-020a3b58baf2d2f70"
role_ec2      = "glr-Role-S3Apps"

# valor de variables autoscaling_group
name_asg = "glr-vpc1-AutoScaling-PROD-CRONOS-ADMIN"
min_size                  = 0
max_size                  = 0
desired_capacity          = 0
#vpc_zone_identifier       = ["subnet-9315fcfe","subnet-9e0ae3f3"]
subnet1                   = "subnet-9e0ae3f3"
subnet2                   = "subnet-9315fcfe"
health_check_grace_period = 60
health_check_type         = "ELB"
termination_policies      = ["NewestInstance"]
target_group_arns = "arn:aws:elasticloadbalancing:us-east-1:543745842878:targetgroup/tg-test/96ac6d1772513e82"
default_cooldown          = 60

# valor de variables tags autoscaling_group
tag_key1   = "Name"
tag_value1 = "CRONOS-ADMIN-ASG"
tag_key2   = "Amb"
tag_value2 = "Prod"
tag_key3   = "Desc"
tag_value3 = "Cronos ADMIN PROD Autoscalling"

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
alarm_name1          = "awsec2-glr-vpc1-AutoScaling-PROD-CRONOS-ADMIN-UP-CPU"
comparison_operator1 = "GreaterThanOrEqualToThreshold"
evaluation_periods1  = "1"
metric_name1         = "CPUUtilization"
namespace1           = "AWS/EC2"
period1              = "300"
statistic1           = "Average"
threshold1           = "60"

# valores variables de "aws_cloudwatch_metric_alarm2" "ec2-down"
alarm_name2          = "awsec2-glr-vpc1-AutoScaling-PROD-CRONOS-ADMIN-DOWN-CPU"
comparison_operator2 = "LessThanOrEqualToThreshold"
evaluation_periods2   = "1"
metric_name2         = "CPUUtilization"
namespace2           = "AWS/EC2"
period2              = "300"
statistic2           = "Average"
threshold2           = 15

#valor de "sns_topic"
topic_arn = "arn:aws:sns:us-east-1:543745842878:Alarma"