resource "aws_lb" "alb-n" {
  name               = "${var.project_name}-alb-n-${var.environment}"
  internal           = false
  load_balancer_type = "network"
  #security_groups    = [aws_security_group.sg-alb-gitlab.id]
  #security_groups    = var.alb_security_groups
  subnets            = [var.subnet1 , var.subnet2]
  enable_deletion_protection = false
}
 

resource "aws_lb_target_group" "tg-n" {
  name        = "${var.project_name}-tg-n-${var.environment}"
  port        = 22
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "instance"
 
  # health_check {
  #  healthy_threshold   = "3"
  #  interval            = "30"
  #  protocol            = "HTTP"
  #  matcher             = "200"
  #  timeout             = "3"
  #  path                = var.health_check_path
  #  unhealthy_threshold = "2"
  # }
}

resource "aws_lb_target_group_attachment" "tg-n" {
  target_group_arn = aws_lb_target_group.tg-n.arn
  target_id        = aws_instance.gitlab.id
  port             = 22
}

resource "aws_lb_listener" "ssh" {
  load_balancer_arn = aws_lb.alb-n.arn
  port              = 22
  protocol          = "TCP"
 
  default_action {
    target_group_arn = aws_lb_target_group.tg-n.arn
    type             = "forward"
   }

}
  # default_action {
  #  type = "redirect"
 
  #  redirect {
  #    port        = 443
  #    protocol    = "HTTPS"
  #    status_code = "HTTP_301"
  #  }
  #}


resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb-n.arn
  port              = 443
  protocol          = "TLS"

  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-west-1:543745842878:certificate/375fe6d5-fbdd-4293-b75d-28ebd1c52f3f"
 
  default_action {
    target_group_arn = aws_lb_target_group.tg-n.arn
    type             = "forward"
   }
}
# resource "aws_alb_listener" "https" {
#   load_balancer_arn = aws_lb.alb-1.id
#   port              = 443
#   protocol          = "HTTPS"
 
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = var.alb_tls_cert_arn
 
#   default_action {
#     target_group_arn = aws_alb_target_group.tg-1.id
#     type             = "forward"
#   }
# }