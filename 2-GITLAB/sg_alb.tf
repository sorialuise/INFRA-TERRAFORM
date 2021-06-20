# resource "aws_security_group" "sg-alb-gitlab" {
#   name   = "${var.project_name}-sg-alb-${var.environment}"
#   vpc_id = var.vpc_id
 
#   ingress {
#    protocol         = "tcp"
#    from_port        = 80
#    to_port          = 80
#    cidr_blocks      = var.list-white
#    #cidr_blocks      = ["0.0.0.0/0"]
#    #ipv6_cidr_blocks = ["::/0"]
#   }
 
#   ingress {
#    protocol         = "tcp"
#    from_port        = 443
#    to_port          = 443
#    #cidr_blocks      = ["0.0.0.0/0"]
#    cidr_blocks      = var.list-white

#   }

  
 
#   egress {
#    protocol         = "-1"
#    from_port        = 0
#    to_port          = 0
#    cidr_blocks      = ["0.0.0.0/0"]
#    ipv6_cidr_blocks = ["::/0"]
#   }
# }