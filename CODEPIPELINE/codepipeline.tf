

resource "aws_codepipeline" "cdp_project" {
  name     = "${var.project_name}-front-${var.environment}"
  role_arn = aws_iam_role.cdp_project_role.arn

  artifact_store {
    location = var.bucket_codepipeline_s3
    type     = "S3"

    # encryption_key {
    #   id   = data.aws_kms_alias.s3kmskey.arn
    #   type = "KMS"
    # }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      
      configuration = {
        PollForSourceChanges  = "false"
        S3Bucket   = var.bucket_code_s3
        S3ObjectKey = var.Object_code_s3
      }

    }
  }

  stage {
    name = "Build"
    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"

      configuration = {
        ProjectName = "test-N1"
      }

      output_artifacts = ["BuildArtifact"]
      
      input_artifacts = ["SourceArtifact"]
     
      namespace = "BuildVariables"

    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      version         = "1"

      configuration = {
        ApplicationName= "TEST-1"
        DeploymentGroupName= "QA"
      }

      input_artifacts = ["SourceArtifact"]
      

      namespace = "DeployVariables"

    }
  }

}


resource "aws_iam_role" "cdp_project_role" {
  name = "${var.project_name}-role"

  assume_role_policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_role_policy" "cdp_project_policy" {
  name = "${var.project_name}-policy"
  role = aws_iam_role.cdp_project_role.id

  policy = file("policy.json")

}


resource "aws_iam_role" "build_project_role" {
  name = "${var.project_name}-build-role"

  assume_role_policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_role_policy" "build_project_policy" {
  name = "${var.project_name}-policy"
  role = aws_iam_role.cdp_project_role.id

  policy = file("policy-build.json")

}
