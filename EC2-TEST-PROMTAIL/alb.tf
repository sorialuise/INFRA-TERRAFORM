resource "aws_alb" "alb-project" {
  depends_on = [aws_security_group.sg-alb-project]
  name               = "vpc1-alb-${var.project_name}-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg-alb-project.id]
  subnets            = [var.subnet1 , var.subnet2]
  enable_deletion_protection = false
}
 

resource "aws_alb_target_group" "tg-project" {
  name        = "vpc1-tg-${var.project_name}-${var.environment}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  deregistration_delay = var.time_deregistration
 
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

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.alb-project.arn
  port              = 80
  protocol          = "HTTP"
 
  # default_action {
  #   target_group_arn = aws_alb_target_group.tg-project.arn
  #   type             = "forward"
  #  }

   default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_302"
    }
  }

}
 
resource "aws_alb_listener" "https" {
 load_balancer_arn = aws_alb.alb-project.id
  port              = 443
  protocol          = "HTTPS"
 
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.alb_tls_cert_arn
 
  default_action {
   target_group_arn = aws_alb_target_group.tg-project.arn
    type             = "forward"
  }
}

resource "aws_alb_target_group_attachment" "project" {
  depends_on = [aws_instance.Project]
  target_group_arn = aws_alb_target_group.tg-project.arn
  target_id        = aws_instance.Project.id
  port             = 80
}
