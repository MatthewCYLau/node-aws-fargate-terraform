resource "aws_cloudwatch_log_group" "dummyapi" {
  name = "awslogs-dummyapi-staging"

  tags = {
    Environment = "staging"
    Application = "dummyapi"
  }
}