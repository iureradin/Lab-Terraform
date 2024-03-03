resource "aws_instance" "example_instance" {
  ami           = var.ami_amazon_ohio
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_pub_example_01.id

  tags = {
    "provider" = "terraform"
    "Name" = "instance_radin"
    "env" = "tmp"
    "owner" = "radin"
  }
}

