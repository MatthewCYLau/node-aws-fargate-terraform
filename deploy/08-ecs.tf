data "template_file" "node_app" {
  template = file("task-definitions/service.json.tpl")
  vars = {
    aws_ecr_repository                   = aws_ecr_repository.node_app.repository_url
    tag                                  = "latest"
    container_name                       = var.app_name
    aws_cloudwatch_log_group_name        = aws_cloudwatch_log_group.node-aws-fargate-app.name
    mongo_password_secret_manager_secret = "${data.aws_secretsmanager_secret.mongo_password_secret.id}:MONGO_PASSWORD::"
    mongo_username                       = var.mongo_username
    mongo_host                           = var.mongo_host
    mongo_database_name                  = var.mongo_database_name
  }
}

resource "aws_ecs_task_definition" "service" {
  family                   = "${var.app_name}-${var.environment}"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = 256
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  container_definitions    = data.template_file.node_app.rendered
  tags = {
    Environment = var.environment
    Application = var.app_name
  }
}

resource "aws_ecs_service" "production" {
  name                       = var.environment
  cluster                    = aws_ecs_cluster.this.id
  task_definition            = aws_ecs_task_definition.service.arn
  desired_count              = 1
  deployment_maximum_percent = 250
  launch_type                = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.public_subnets[*].id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.app_name
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.https_forward, aws_iam_role_policy.ecs_task_execution_role]

  tags = {
    Environment = var.environment
    Application = var.app_name
  }
}

resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-cluster"
}