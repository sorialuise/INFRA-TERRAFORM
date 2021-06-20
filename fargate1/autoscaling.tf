resource "aws_appautoscaling_target" "asg_ecs_target"{
  max_capacity       = 3
  min_capacity       = 3
  resource_id        = "service/${aws_ecs_cluster.cluster-1.name}/${aws_ecs_service.service-1.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}