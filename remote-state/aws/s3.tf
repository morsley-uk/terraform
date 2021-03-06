resource "aws_s3_bucket" "terraform-bucket" {
    bucket        = var.terraform_bucket
    acl           = "private"
    force_destroy = true

    versioning {
        enabled = true
    }
}