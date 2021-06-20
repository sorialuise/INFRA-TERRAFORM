resource "aws_ecs_cluster" "cluster-1" {
  name = "${var.project_name}-cluster-${var.environment}"
}