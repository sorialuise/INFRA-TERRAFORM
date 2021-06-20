# data "aws_efs_file_system" "efs-project" {
#   file_system_id = var.file_system_id
# }

resource "aws_ecs_task_definition" "taskd1" {
  depends_on = [aws_efs_file_system.efs-project]
  family                   = "${var.project_name}-${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

volume {
    name = "${var.project_name}-home"
    efs_volume_configuration {
        file_system_id = aws_efs_file_system.efs-project.id
        transit_encryption      = "ENABLED"

        authorization_config {
        access_point_id = aws_efs_access_point.efs_access-project.id
        iam             = "ENABLED"
        } 

    }
    
  }

  container_definitions = file("6-service.json")

}

resource "aws_cloudwatch_log_group" "project" {
  name = "${var.project_name}-${var.environment}"
  retention_in_days = 1
 
}