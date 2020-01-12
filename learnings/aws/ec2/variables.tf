###############################################################################
# VARIABLES 
###############################################################################

variable "access_key" {}

variable "secret_key" {}

variable "private_key_path" {}

# 

variable ec2_ami {}

variable ec2_user {}

variable "key_name" {}

variable "region" {
  default = "eu-west-2" # London
}

variable "network_address_space" {
  default = "10.0.0.0/16" # 65,536 - 5 = 65,531
}

variable "public_subnet_01_address_space" {
  default = "10.0.0.0/24" # 256 - 5 = 251
}
