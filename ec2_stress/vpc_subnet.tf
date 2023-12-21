resource "aws_vpc" "vpc_example" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "provider" = "terraform"
    "Name"     = "vpc_radin"
    "env"      = "tmp"
    "owner"    = "radin"
  }
}

resource "aws_internet_gateway" "igw_example" {
  vpc_id = aws_vpc.vpc_example.id

  tags = {
    "provider" = "terraform"
    "Name"     = "igw_radin"
    "env"      = "tmp"
    "owner"    = "radin"
  }
}

resource "aws_subnet" "subnet_priv_example_01" {
  vpc_id     = aws_vpc.vpc_example.id
  cidr_block = var.subnet_priv_cidr_block

  tags = {
    "provider" = "terraform"
    "Name"     = "sub-priv-radin-01"
    "env"      = "tmp"
    "owner"    = "radin"
  }
}

resource "aws_subnet" "subnet_pub_example_01" {
  vpc_id     = aws_vpc.vpc_example.id
  cidr_block = var.subnet_pub_cidr_block

  tags = {
    "provider" = "terraform"
    "Name"     = "sub-pub-radin-01"
    "env"      = "tmp"
    "owner"    = "radin"
  }
}

resource "aws_route_table" "route_table_example" {
  vpc_id = aws_vpc.vpc_example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_example.id
  }
}

resource "aws_route_table_association" "route_table_association_example" {
  subnet_id      = aws_subnet.subnet_pub_example_01.id
  route_table_id = aws_route_table.route_table_example.id
}
