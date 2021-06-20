resource "aws_ecs_service" "service-1" {
 name                               = "${var.project_name}-service-${var.environment}"
 cluster                            = aws_ecs_cluster.cluster-1.id
 task_definition                    = aws_ecs_task_definition.taskd1.arn
 desired_count                      = 2
 deployment_minimum_healthy_percent = 50
 deployment_maximum_percent         = 200
 launch_type                        = "FARGATE"
 scheduling_strategy                = "REPLICA"
 
 network_configuration {
   security_groups  = [aws_security_group.sg-ecs_tasks.id]
   subnets          = [var.subnet1 , var.subnet2]
   assign_public_ip = true
 }
 
 load_balancer {
   target_group_arn = aws_alb_target_group.tg-1.arn
   container_name   = "${var.project_name}-container-${var.environment}"
   container_port   = var.container_port
 }
 
 lifecycle {
   ignore_changes = [task_definition, desired_count]
 }
}