data "template_file" "node_app" {
  template = file("task-definitions/service.json.tpl")
  vars = {
    aws_ecr_repository            = aws_ecr_repository.node_app.repository_url
    tag                           = "latest"
    aws_cloudwatch_log_group_name = aws_cloudwatch_log_group.node-aws-fargate-app.name
  }
}

resource "aws_ecs_task_definition" "service" {
  family                   = "node-aws-fargate-app-staging"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = 256
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  container_definitions    = data.template_file.node_app.rendered
  tags = {
    Environment = "staging"
    Application = "node-aws-fargate-app"
  }
}

resource "aws_ecs_service" "staging" {
  name                       = "staging"
  cluster                    = aws_ecs_cluster.staging.id
  task_definition            = aws_ecs_task_definition.service.arn
  desired_count              = 1
  deployment_maximum_percent = 250
  launch_type                = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = [aws_subnet.pub_subnet.id, aws_subnet.pub_subnet2.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.staging.arn
    container_name   = "node-aws-fargate-app"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.https_forward, aws_iam_role_policy.ecs_task_execution_role]

  tags = {
    Environment = "staging"
    Application = "node-aws-fargate-app"
  }
}

resource "aws_ecs_cluster" "staging" {
  name = "node-app-ecs-cluster"
}