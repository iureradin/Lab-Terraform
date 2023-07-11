resource "aws_vpc" "example_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "provider" = "terraform"
    "Name" = "default_vpc"
  }
}

resource "aws_subnet" "example_subnet" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = var.subnet_cidr_block
  tags = {
    "provider" = "terraform"
    "Name" = "sub-priv1"
  }
}
