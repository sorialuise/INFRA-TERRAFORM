resource "aws_codebuild_project" "cdb-project" {
  name          = "${var.project_name}-build-${var.environment}"
  description   = "${var.project_name}-build-${var.environment}"
  build_timeout = "5"
  service_role  = aws_iam_role.build_project_role.arn

  source {
    type        = "CODEPIPELINE"
    insecure_ssl = false
  }

  artifacts {
    type = "CODEPIPELINE"
    name = "perulegal-front-node-prod"
    packaging = "NONE"
    encryption_disabled = false

  }

  cache {
    type     = "NO_CACHE"
  }

  environment {
    type                        = "LINUX_CONTAINER"
    image                       = "aws/codebuild/standard:5.0"
    compute_type                = "BUILD_GENERAL1_SMALL"
    privileged_mode =  false
    image_pull_credentials_type = "CODEBUILD"
  }

  vpc_config {
    vpc_id = var.vpc_id

    subnets = [
      var.subnet_1
    ]

    security_group_ids = [
      aws_security_group.sg1-project.id
    ]
  }

  logs_config {
    cloudwatch_logs {
      status   = "ENABLED"
    }

    s3_logs {
      status   = "ENABLED"
      encryption_disabled = false
    }
  }

  
}
