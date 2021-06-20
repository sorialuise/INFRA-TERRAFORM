resource "aws_lb" "alb-1" {
  name               = "${var.project_name}-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg-alb-1.id]
  #security_groups    = var.alb_security_groups
  subnets            = [var.Public-subnet1 , var.Public-subnet2]
  enable_deletion_protection = false
}
 

resource "aws_alb_target_group" "tg-1" {
  depends_on = [aws_lb.alb-1]
  name        = "${var.project_name}-tg-${var.environment}"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
 
  health_check {
   healthy_threshold   = "5"
   interval            = "90"
   protocol            = "HTTP"
   matcher             = "200"
   timeout             = "80"
   path                = var.health_check_path
   unhealthy_threshold = "4"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.alb-1.arn
  port              = 80
  protocol          = "HTTP"
 
  default_action {
    target_group_arn = aws_alb_target_group.tg-1.arn
    type             = "forward"
   }

  # default_action {
  #  type = "redirect"
 
  #  redirect {
  #    port        = 443
  #    protocol    = "HTTPS"
  #    status_code = "HTTP_301"
  #  }
  #}
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