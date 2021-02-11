resource "aws_ecr_repository" "app_image_repository" {
  name = "sample-node-ecr-repository"
}

output "app_image_repository_url" {
  value = aws_ecr_repository.app_image_repository.repository_url
}

output "app_image_repository_arn" {
  value = aws_ecr_repository.app_image_repository.arn
}