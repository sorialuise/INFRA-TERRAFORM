resource "aws_security_group" "sg-project" {
  name   = "vp1-${var.project_name}-${var.environment}-web-sg"
  vpc_id = var.vpc_id
 
  ingress {
   protocol         = "tcp"
   from_port        = 80
   to_port          = 80
   cidr_blocks      = var.list-white
  }

  ingress {
   protocol         = "tcp"
   from_port        = 80
   to_port          = 80
   security_groups  = [aws_security_group.sg-alb-project.id]
   description = "alb-${var.project_name}-${var.environment}-sg"
  }
  
  ingress {
   protocol         = "tcp"
   from_port        = 443
   to_port          = 443
   cidr_blocks      = var.list-white
  }

  ingress {
   protocol         = "tcp"
   from_port        = 22
   to_port          = 22
   cidr_blocks      = var.list-white
  }

  ingress {
   protocol         = "tcp"
   from_port        = 3000
   to_port          = 3000
   cidr_blocks      = var.list-white
  }
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
}