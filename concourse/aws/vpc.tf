###############################################################################
# VPC
###############################################################################

resource "aws_vpc" "vpc_concourse" {
    
  tags = {
    "Name" = "vpc-concourse"
  }

  cidr_block           = var.network_address_space
  enable_dns_hostnames = true

}

output "aws_vpc_id" {

  value = aws_vpc.vpc_concourse.id

}

###############################################################################
# INTERNET GATEWAY
###############################################################################

# ?

resource "aws_internet_gateway" "igw_concourse" {
    
  vpc_id = aws_vpc.vpc_concourse.id

  tags = {
    Name = "igw-concourse"
  }

}

###############################################################################
# PUBLIC SUBNETS
###############################################################################

resource "aws_subnet" "public_subnet_01" {

  vpc_id = aws_vpc.vpc_concourse.id

  tags = {
    Name = "vpc-concourse-public-subnet-01"
  }

  cidr_block              = var.public_subnet_01_address_space
  map_public_ip_on_launch = true

}

###############################################################################
# ROUTING
###############################################################################

# ?

resource "aws_route_table" "rt_concourse" {

  vpc_id = aws_vpc.vpc_concourse.id

  tags = {
    Name = "rt-concourse"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_concourse.id
  }

}

resource "aws_route_table_association" "rta_public_subnet_01" {

  subnet_id      = aws_subnet.public_subnet_01.id
  route_table_id = aws_route_table.rt_concourse.id
  
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

resource "aws_security_group" "security_group_concourse" {

  name        = "security-group-concourse"
  description = "Allowed ports"
  vpc_id      = aws_vpc.vpc_concourse.id
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 800
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