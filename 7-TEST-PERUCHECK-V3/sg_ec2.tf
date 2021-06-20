# data "aws_vpc" "import_vpc" {
#   id = var.vpc_id
# }

resource "aws_security_group" "sg-project01" {
  name   = "${var.project_name}-sg-${var.environment}"
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
   security_groups  = [aws_security_group.sg-alb-project01.id]
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