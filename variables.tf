variable "aws_access_key" {
  description = ""
}

variable "aws_secret_key" {
  description = ""
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  default     = "10.0.0.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.nano"
}
