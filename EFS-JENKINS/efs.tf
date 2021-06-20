resource "aws_efs_file_system" "efs-project" {
   creation_token = var.project_name
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
 tags = {
     Name = var.project_name
   }
 }

resource "aws_efs_mount_target" "efs-mt1-project" {
   file_system_id  = aws_efs_file_system.efs-project.id
   subnet_id = var.subnet1
   security_groups = [aws_security_group.sg_efs_project.id]
 }

resource "aws_efs_mount_target" "efs-mt2-project" {
   file_system_id  = aws_efs_file_system.efs-project.id
   subnet_id = var.subnet2
   security_groups = [aws_security_group.sg_efs_project.id]
 }
