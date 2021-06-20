resource "aws_autoscaling_policy" "policy_1" {
  name                   = var.policy1_name
  policy_type            = var.policy1_type 
  scaling_adjustment     = var.scaling1_adjustment
  adjustment_type        = var.adjustment1_type
  cooldown               = var.cooldown1
  autoscaling_group_name = aws_autoscaling_group.asgcadmin.name
}

resource "aws_autoscaling_policy" "policy_2" {
  name                   = var.policy2_name
  policy_type            = var.policy2_type 
  scaling_adjustment     = var.scaling2_adjustment
  adjustment_type        = var.adjustment2_type
  cooldown               = var.cooldown2
  autoscaling_group_name = aws_autoscaling_group.asgcadmin.name
}

