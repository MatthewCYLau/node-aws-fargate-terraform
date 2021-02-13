provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "node-app-tf-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_caller_identity" "current" {}