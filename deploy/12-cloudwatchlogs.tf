resource "aws_cloudwatch_log_group" "node-aws-fargate-app" {
  name = "awslogs-node-aws-fargate-app"

  tags = {
    Environment = var.environment
    Application = var.app_name
  }
}