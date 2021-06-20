resource "aws_launch_configuration" "launchconfig" {
  name   = var.launch_name
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name = var.ec2_key_name
  ebs_optimized = var.ebs_optimized
  security_groups = [aws_security_group.sg-project.id]
  iam_instance_profile = var.role_ec2
 

}