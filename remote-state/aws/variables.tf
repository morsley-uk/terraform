variable "access_key" {}

variable "secret_key" {}

variable "region" {
  default = "eu-west-2" # London
}

variable "terraform_bucket" {
  default = "morsley-uk-terraform"
}

variable "terraform_table" {
  default = "morsley-uk-terraform"
}