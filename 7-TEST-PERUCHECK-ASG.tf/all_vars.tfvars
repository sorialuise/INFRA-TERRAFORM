# valor de variables provider
region = "us-west-1"

# valor de variables launch_configuration
lc_name       = "glr-launchconfiguration-PROD-PeruCheck"
image_id      = "ami-04d7c565de3406783"
instance_type = "t3.medium"
ebs_optimized = "true"
ec2_key_name  = "glr-gitlab-qa"
sg            = "sg-0f662afc26378ea71"
role_ec2      = "glr-Role-S3Apps"

# valor de variables autoscaling_group
name_asg = "glr-vpc1-AutoScaling-PROD-PeruCheck"
desired_capacity          = 1
min_size                  = 1
max_size                  = 4

#vpc_zone_identifier       = ["subnet-9315fcfe","subnet-9e0ae3f3"]
subnet1                   = "subnet-00679ca9378e9afd0"
subnet2                   = "subnet-0b15545a362ebebef"
health_check_grace_period = 60
health_check_type         = "ELB"
termination_policies      = ["NewestInstance"]
target_group_arns = "arn:aws:elasticloadbalancing:us-west-1:543745842878:targetgroup/tg-test/dd7ec15231006400"
default_cooldown          = 60

# valor de variables tags autoscaling_group
tag_key1   = "Name"
tag_value1 = "PROD-PERUCHECK-ASG"
tag_key2   = "Amb"
tag_value2 = "Prod"
tag_key3   = "Desc"
tag_value3 = "PERUCHECK PROD Autoscalling"

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
alarm_name1          = "awsec2-glr-vpc1-AutoScaling-PROD-PERUCHECK-UP-CPU"
comparison_operator1 = "GreaterThanOrEqualToThreshold"
evaluation_periods1  = "1"
metric_name1         = "CPUUtilization"
namespace1           = "AWS/EC2"
period1              = "60"
statistic1           = "Average"
threshold1           = "60"

# valores variables de "aws_cloudwatch_metric_alarm2" "ec2-down"
alarm_name2          = "awsec2-glr-vpc1-AutoScaling-PROD-PERUCHECK-DOWN-CPU"
comparison_operator2 = "LessThanOrEqualToThreshold"
evaluation_periods2   = "2"
metric_name2         = "CPUUtilization"
namespace2           = "AWS/EC2"
period2              = "300"
statistic2           = "Average"
threshold2           = 15

#valor de "sns_topic"
topic_arn = "arn:aws:sns:us-west-1:543745842878:Alarma-CN"