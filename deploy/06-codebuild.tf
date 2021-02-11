resource "aws_codebuild_project" "node_express_ecs_codebuild_project" {
  name          = "node_express_ecs_codebuild_project"
  description   = "node_express_ecs_codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.node_express_ecs_codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.default_region
    }

    environment_variable {
      name  = "DOCKER_USERNAME"
      value = var.docker_username
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }

    environment_variable {
      name  = "IMAGE_NAME"
      value = "sample-node-app"
    }

    environment_variable {
      name  = "ECR_REPO_URL"
      value = aws_ecr_repository.app_image_repository.repository_url
    }
  }

  source {
    type = "CODEPIPELINE"
  }
}