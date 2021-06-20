resource "aws_ecs_service" "service-1" {
 depends_on = [aws_alb_listener.http]
 name                               = "${var.project_name}-service-${var.environment}"
 cluster                            = aws_ecs_cluster.cluster-1.id
 task_definition                    = aws_ecs_task_definition.taskd1.arn
 desired_count                      = 1
 deployment_minimum_healthy_percent = 0
 deployment_maximum_percent         = 100
 launch_type                        = "FARGATE"
 scheduling_strategy                = "REPLICA"

 platform_version = "1.4.0"
 
 network_configuration {
   security_groups  = [aws_security_group.sg-ecs_tasks.id]
   subnets          = [var.Private-subnet1 , var.Private-subnet2]
   assign_public_ip = true
 }
 
 load_balancer {
   target_group_arn = aws_alb_target_group.tg-1.arn
   container_name   = "${var.project_name}-container-${var.environment}"
   container_port   = var.container_port
 }

 service_registries {
   registry_arn = aws_service_discovery_service.jenkins.arn
   port = var.container_port2
 }
 
 lifecycle {
   ignore_changes = [task_definition, desired_count]
 }
}
