resource "aws_security_group" "sg_efs_project" {
  name = var.project_name
  vpc_id = var.vpc_id

   // NFS
   ingress {
     cidr_blocks = [var.cidr_block]
     #security_groups = ["${aws_security_group.ingress-test-env.id}"]
     from_port = 2049
     to_port = 2049
     protocol = "tcp"
   }

   // Terraform removes the default rule
   egress {
     cidr_blocks = [var.cidr_block]
     #security_groups = ["${aws_security_group.ingress-test-env.id}"]
     from_port = 0
     to_port = 0
     protocol = "-1"
   }
}

