###############################################################################
# PROVIDER - AWS
###############################################################################

# https://www.terraform.io/docs/providers/aws/index.html

provider "aws" {
  version    = "~> 2.0"
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}