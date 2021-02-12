resource "aws_s3_bucket" "node_app" {
  bucket        = var.bucket_name
  acl           = "private"
  force_destroy = true

}