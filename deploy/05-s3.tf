resource "aws_s3_bucket" "node_express_ecs_s3_bucket" {
  bucket        = var.bucket_name
  acl           = "public-read"
  force_destroy = true

}