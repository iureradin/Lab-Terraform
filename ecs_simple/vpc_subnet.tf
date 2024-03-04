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
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-2a"

  tags = {
    "provider" = "terraform"
    "Name"     = "sub-priv-radin-01"
    "env"      = "tmp"
    "owner"    = "radin"
  }
}

resource "aws_subnet" "subnet_priv_example_02" {
  vpc_id     = aws_vpc.vpc_example.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2b"

  tags = {
    "provider" = "terraform"
    "Name"     = "sub-priv-radin-02"
    "env"      = "tmp"
    "owner"    = "radin"
  }
}

resource "aws_subnet" "subnet_pub_example_01" {
  vpc_id     = aws_vpc.vpc_example.id
  cidr_block = "10.0.50.0/24"
  availability_zone = "us-east-2a"

  tags = {
    "provider" = "terraform"
    "Name"     = "sub-pub-radin-01"
    "env"      = "tmp"
    "owner"    = "radin"
  }
}

resource "aws_subnet" "subnet_pub_example_02" {
  vpc_id     = aws_vpc.vpc_example.id
  cidr_block = "10.0.51.0/24"
  availability_zone = "us-east-2b"

  tags = {
    "provider" = "terraform"
    "Name"     = "sub-pub-radin-02"
    "env"      = "tmp"
    "owner"    = "radin"
  }
}

resource "aws_route_table" "route_table_sub_pub_example" {
  vpc_id = aws_vpc.vpc_example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_example.id
  }
}

resource "aws_route_table_association" "route_table_association_pub_01" {
  subnet_id      = aws_subnet.subnet_pub_example_01.id
  route_table_id = aws_route_table.route_table_sub_pub_example.id
}

resource "aws_route_table_association" "route_table_association_pub_02" {
  subnet_id      = aws_subnet.subnet_pub_example_02.id
  route_table_id = aws_route_table.route_table_sub_pub_example.id
}

resource "aws_route_table" "route_table_sub_priv_example" {
  vpc_id = aws_vpc.vpc_example.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "route_table_association_priv_01" {
  subnet_id      = aws_subnet.subnet_priv_example_01.id
  route_table_id = aws_route_table.route_table_sub_priv_example.id
}

resource "aws_route_table_association" "route_table_association_priv_02" {
  subnet_id      = aws_subnet.subnet_priv_example_02.id
  route_table_id = aws_route_table.route_table_sub_priv_example.id
}

resource "aws_eip" "nat" {
  vpc = true
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = aws_subnet.subnet_pub_example_01.id
}
