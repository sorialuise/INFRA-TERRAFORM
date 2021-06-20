resource "aws_ecs_task_definition" "taskd1" {
  family                   = "service-peru-legal"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = file("service.json")

  # container_definitions = [
  #   {
  #     name        = "${var.project_name}-container-${var.environment}"
  #     image       = "${var.container_image}:latest"
  #     essential   = true
  #     environment = var.container_environment
  #     portMappings = [
  #       {protocol      = "tcp"},
  #       {containerPort = var.container_port},
  #       {hostPort      = var.container_port},
  #   ]
    
  #   }
  # ]
#     container_definitions = <<TASK_DEFINITION
# [
#     {
#         "environment": [
#             {"name": "VARNAME", "value": "${var.project_name}-container-${var.environment}"}
#         ],
#         "essential": true,
#         "image": "${var.container_image}:latest",
#         "name": "${var.project_name}-container-${var.environment}",
#         "portMappings": [
#             {
#                 "protocol" : "tcp"
#                 "containerPort": ${var.container_port},
#                 "hostPort": ${var.container_port}
#             }
#         ]

#     }
# ]
# TASK_DEFINITION


}

