
### Valores generales del proyecto
project_name = "TEST1"
environment = "qa"
vpc_id = "vpc-6a034710"
region = "us-east-1"

#Certificado HTTPS
#alb_tls_cert_arn = "arn:aws:acm:us-east-1:543745842878:certificate/78b72d3a-0934-4564-9936-c6489b59978c"

#valor de "sns_topic"
topic_arn = "arn:aws:sns:us-east-1:731451121490:sns-test1"

###IP PERMITIDAS PUERTO 22 80 y 3000
sg_bastion = "sg-a9c71ad1"
sg_jenkins = "sg-933a2deb"

# valor de variables launch_configuration
launch_name   = "glr-launchconfiguration-TES1"
image_id      = "ami-02a62e23582dee20e"
instance_type = "t2.micro"
ebs_optimized = "true"
ec2_key_name  = "test-redhat"
role_ec2      = "lesb-Role-S3Apps"

# valor de variables autoscaling_group
name_asg = "glr-vpc1-AutoScaling-PROD-TEST1"
min_size                  = 0
max_size                  = 0
desired_capacity          = 0
subnet1                   = "subnet-9ec02290"  
subnet2                   = "subnet-11f8cf3f"
health_check_grace_period = 60
health_check_type         = "ELB"
termination_policies      = ["NewestInstance"]
default_cooldown          = 60

# valor de variables target_group
health_check_path = "/backend-status"
time_deregistration = "150"

# valor de variables tags autoscaling_group
tag_name = "TEST1-PROD-ASG"
tag_env = "Prod"
tag_desc = "TEST1 PROD Autoscalling"
tag_deploy = "TEST1-PROD-ASG"


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
alarm_name1          = "awsec2-glr-vpc1-AutoScaling-PROD-TEST1-CPU-HIGH-Increase"
comparison_operator1 = "GreaterThanOrEqualToThreshold"
evaluation_periods1  = "1"
metric_name1         = "CPUUtilization"
namespace1           = "AWS/EC2"
period1              = "300"
statistic1           = "Average"
threshold1           = "60"

# valores variables de "aws_cloudwatch_metric_alarm2" "ec2-down"
alarm_name2          = "awsec2-glr-vpc1-AutoScaling-PROD-TEST1-CPU-DOWN-Decrese"
comparison_operator2 = "LessThanOrEqualToThreshold"
evaluation_periods2   = "1"
metric_name2         = "CPUUtilization"
namespace2           = "AWS/EC2"
period2              = "300"
statistic2           = "Average"
threshold2           = 15
