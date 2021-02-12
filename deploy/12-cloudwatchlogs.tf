resource "aws_cloudwatch_log_group" "node-aws-fargate-app" {
  name = "awslogs-node-aws-fargate-app-staging"

  tags = {
    Environment = "staging"
    Application = "node-aws-fargate-app"
  }
}