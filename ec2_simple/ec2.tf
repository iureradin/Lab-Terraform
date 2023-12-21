resource "aws_instance" "example_instance" {
  ami           = "ami-053b0d53c279acc90"  # Substitua pelo ID da AMI do Ubuntu
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_pub_example_01.id

  tags = {
    "provider" = "terraform"
    "Name" = "instance_radin"
    "env" = "tmp"
    "owner" = "radin"
  }
}

