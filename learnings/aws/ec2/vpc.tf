###############################################################################
# VPC
###############################################################################

resource "aws_vpc" "vpc_jm" {
    
  tags = {
    "Name" = "vpc-jm"
  }

  cidr_block           = var.network_address_space
  enable_dns_hostnames = true

}

output "aws_vpc_id" {

  value = aws_vpc.vpc_jm.id

}

###############################################################################
# INTERNET GATEWAY
###############################################################################

# ?

resource "aws_internet_gateway" "igw_jm" {
    
  vpc_id = aws_vpc.vpc_jm.id

  tags = {
    Name = "igw-jm"
  }

}

###############################################################################
# PUBLIC SUBNETS
###############################################################################

resource "aws_subnet" "public_subnet_01" {

  vpc_id = aws_vpc.vpc_jm.id

  tags = {
    Name = "vpc-jm-public-subnet-01"
  }

  cidr_block              = var.public_subnet_01_address_space
  map_public_ip_on_launch = true

}

# resourse "aws_subnet" "vpc-jm-public-subnet-2" {
#     vpc_id = aws_vpc.vpc-jm.id
#     tags = {
#         Name = "vpc-jm-public-subnet-2"
#     }
#     cidr_block = "10.0.0.0/24" # 256 - 5 = 251
# }

###############################################################################
# PRIVATE SUBNETS
###############################################################################

# Private because they don't have an Internet Gateway?

# resourse "aws_subnet" "vpc-jm-private-subnet-1" {

# }

# resourse "aws_subnet" "vpc-jm-private-subnet-2" {

# }

###############################################################################
# ROUTING
###############################################################################

# ?

resource "aws_route_table" "rt_jm" {

  vpc_id = aws_vpc.vpc_jm.id

  tags = {
    Name = "rt-jm"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_jm.id
  }

}

resource "aws_route_table_association" "rta_public_subnet_01" {

  subnet_id      = aws_subnet.public_subnet_01.id
  route_table_id = aws_route_table.rt_jm.id
  
}

###############################################################################
# NETWORK ACL
###############################################################################

# ?

###############################################################################
# DHCP OPTIONS SET
###############################################################################

# ?

###############################################################################
# SECURITY GROUPS
###############################################################################

# ?

resource "aws_security_group" "security_group_jm" {

  name        = "security-group-jm"
  description = "Allowed ports"
  vpc_id      = aws_vpc.vpc_jm.id
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   from_port = 80
  #   to_port = 80
  #   protocol = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}