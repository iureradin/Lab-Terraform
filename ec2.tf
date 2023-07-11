resource "aws_instance" "example_instance" {
  ami           = "ami-053b0d53c279acc90"  # Substitua pelo ID da AMI do Ubuntu
  instance_type = var.instance_type
  subnet_id     = aws_subnet.example_subnet.id

  tags = {
    "provider" = "terraform"
    "Name" = "instance1"
  }
}