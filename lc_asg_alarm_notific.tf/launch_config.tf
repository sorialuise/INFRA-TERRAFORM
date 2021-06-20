resource "aws_launch_configuration" "launchconfig" {
  name   = var.lc_name
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name = var.ec2_key_name
  ebs_optimized = var.ebs_optimized
  security_groups = [var.sg]
  iam_instance_profile = var.role_ec2
 
  lifecycle {
    create_before_destroy = true
  }

}