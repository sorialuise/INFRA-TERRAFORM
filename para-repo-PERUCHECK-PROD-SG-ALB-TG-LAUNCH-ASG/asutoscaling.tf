resource "aws_autoscaling_group" "asg-project" {
  depends_on = [aws_alb_target_group.tg-project]
  name                      = var.name_asg
  launch_configuration      = aws_launch_configuration.launchconfig.name
  vpc_zone_identifier       = [var.subnet1, var.subnet2]
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  termination_policies      = var.termination_policies
  target_group_arns         = [aws_alb_target_group.tg-project.arn]
  default_cooldown          = var.default_cooldown

  lifecycle {
    create_before_destroy = true
  }

  tags = [
    {
      key                 = "Name"
      value               = var.tag_name
      propagate_at_launch = true
    },
    {
      key                 = "Env"
      value               = var.tag_env
      propagate_at_launch = true
    },
    {
      key                 = "Deploy"
      value               = var.tag_deploy
      propagate_at_launch = true
    },

    {
      key                 = "Desc"
      value               = var.tag_desc
      propagate_at_launch = true
    },


  ]
}


resource "aws_cloudwatch_metric_alarm" "ec2-up" {
  alarm_name          = var.alarm_name1
  comparison_operator = var.comparison_operator1
  evaluation_periods  = var.evaluation_periods1
  metric_name         = var.metric_name1
  namespace           = var.namespace1
  period              = var.period1
  statistic           = var.statistic1
  threshold           = var.threshold1

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg-project.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.policy_1.arn, var.topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "ec2-down" {
  alarm_name          = var.alarm_name2
  comparison_operator = var.comparison_operator2
  evaluation_periods  = var.evaluation_periods2
  metric_name         = var.metric_name2
  namespace           = var.namespace2
  period              = var.period2
  statistic           = var.statistic2
  threshold           = var.threshold2

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg-project.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.policy_2.arn, var.topic_arn]
}

resource "aws_autoscaling_notification" "notifications_asg" {
  group_names = [aws_autoscaling_group.asg-project.name]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = var.topic_arn
}

