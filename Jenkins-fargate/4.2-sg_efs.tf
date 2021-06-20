resource "aws_security_group" "sg_efs_project" {
  name = "efs-task-${var.project_name}-sg"
  vpc_id = var.vpc_id

   // NFS
   ingress {
     security_groups = [aws_security_group.sg-ecs_tasks.id]
     from_port = 2049
     to_port = 2049
     protocol = "tcp"
   }

   // Terraform removes the default rule
   egress {
     security_groups = [aws_security_group.sg-ecs_tasks.id]
     from_port = 0
     to_port = 0
     protocol = "-1"
   }
}

