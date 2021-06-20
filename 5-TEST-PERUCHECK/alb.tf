resource "aws_alb" "alb-project01" {
  name               = "${var.project_name}-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg-alb-project01.id]
  #security_groups    = var.alb_security_groups
  subnets            = [var.subnet1 , var.subnet2]
  enable_deletion_protection = false
}
 

resource "aws_alb_target_group" "tg-project01" {
  name        = "${var.project_name}-tg-${var.environment}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
 
  health_check {
   healthy_threshold   = "3"
   interval            = "30"
   protocol            = "HTTP"
   matcher             = "200"
   timeout             = "3"
   path                = var.health_check_path
   unhealthy_threshold = "2"
  }
}

resource "aws_alb_target_group_attachment" "tg-project01" {
  target_group_arn = aws_alb_target_group.tg-project01.arn
  target_id        = aws_instance.project01.id
  port             = 80
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.alb-project01.arn
  port              = 80
  protocol          = "HTTP"
 
  default_action {
    target_group_arn = aws_alb_target_group.tg-project01.arn
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