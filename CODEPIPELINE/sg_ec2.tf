resource "aws_security_group" "sg1-project" {
  name   = "vp1-${var.project_name}-${var.environment}-web-sg"
  vpc_id = var.vpc_id
 

  ingress {
   protocol         = "tcp"
   from_port        = 80
   to_port          = 80
   #security_groups  = [aws_security_group.sg-alb-project.id]
   #description = "alb-${var.project_name}-${var.environment}-sg"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress {
   protocol         = "tcp"
   from_port        = 22
   to_port          = 22
   #security_groups      = [var.sg_bastion]
   #description = "sg-Bastion"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
}