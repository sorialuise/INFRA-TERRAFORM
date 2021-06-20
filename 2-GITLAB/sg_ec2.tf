# data "aws_vpc" "import_vpc" {
#   id = var.vpc_id
# }

####  SG-EC2
resource "aws_security_group" "sg-ec2-1" {
  name   = "${var.project_name}-sg-${var.environment}"
  vpc_id = var.vpc_id
 
  ingress {
   protocol         = "tcp"
   from_port        = 80
   to_port          = 80
   #cidr_blocks      = [data.aws_vpc.import_vpc.cidr_block]
   #cidr_address      = [aws_security_group.sg-alb-gitlab.id]
   #security_group_id = aws_security_group.sg-alb-gitlab.id
   cidr_blocks      = var.list-white
  }
 
  ingress {
   protocol         = "tcp"
   from_port        = 443
   to_port          = 443
   #security_group_id = aws_security_group.sg-alb-gitlab.id
   cidr_blocks      = var.list-white
  }

  ingress {
   protocol         = "tcp"
   from_port        = 22
   to_port          = 22
   cidr_blocks      = var.list-white

  }
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = var.list-white
  }
}