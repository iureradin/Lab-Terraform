
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.nano"
}

variable "ami_amazon_ohio" {
  description = "AMI Amazon Linux from Ohio"
  default = "ami-02ca28e7c7b8f8be1"
}

variable "app_desired_count" {
  description = "Desired count to service ECS"
  default = "1"
}

