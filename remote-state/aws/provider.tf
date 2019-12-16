provider "aws" {
  version = "~> 2.0"
  region = "eu-west-2" # London
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}