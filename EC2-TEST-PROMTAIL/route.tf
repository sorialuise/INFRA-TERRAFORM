data "aws_route53_zone" "project" {
  name = "glr.pe"

}


resource "aws_route53_record" "project" {
  depends_on = [aws_alb.alb-project]
  zone_id = data.aws_route53_zone.project.zone_id
  name    = "testpmtail"
  type    = "A"

  alias {
    name                   = aws_alb.alb-project.dns_name
    zone_id                = aws_alb.alb-project.zone_id
    evaluate_target_health = true
  }
}