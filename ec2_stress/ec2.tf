resource "aws_instance" "example_instance" {
  ami           = var.ami_amazon_ohio
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_pub_example_01.id
  vpc_security_group_ids = [aws_security_group.permitir_ssh_http.id]
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"

  tags = {
    "provider" = "terraform"
    "Name" = "ec2_stress"
    "env" = "tmp"
    "owner" = "radin"
  }
  user_data = <<EOF
#!/bin/bash
echo "Copying the SSH Key to the server"
dnf update -y
dnf install stress -y
echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCr+HUf/5jE47oVa/pVDLkh9a+89QievVssAOYPNcO/lKV9eglngPNTB6Fnv+V08CJFRaOfBwMBTbvCUjDvtEbuVtfE++BPAMaKsO7sxFm28kE3oF3P+dVqC3uPPSzwoEYPJogSqVxq4w5iOUO0//57Ol1h15b+h8q3jDgRtNml9er0gBsM0asAvtdscROkpQeN8hLUOSwFkVM7ZMAWc2Yczjbb4MWvJPHVvA5Cn6IxFnKRTo4LEL4I4oVuN13HtOC9ft4rQslS5PKLqB29SAwJPYI/3G50RCnqyACJdNeb0iGJ7gZYaCMF0x0zEF49a61DXlMBkqon9QX+ittU5ia5 iure@KAKASHI" >> /home/ubuntu/.ssh/authorized_keys
sleep 60
stress -c 2 --timeout 1800
EOF   
}

resource "aws_security_group" "permitir_ssh_http" {
  name        = "permitir_ssh"
  description = "Permite SSH e HTTP na instancia EC2"
  vpc_id      = aws_vpc.vpc_example.id

  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "permitir_ssh_e_http"
  }
}

resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
     alarm_name                = "cpu-utilization"
     comparison_operator       = "GreaterThanOrEqualToThreshold"
     evaluation_periods        = "1"
     metric_name               = "CPUUtilization"
     namespace                 = "AWS/EC2"
     period                    = "120" #seconds
     statistic                 = "Average"
     threshold                 = "30"
     alarm_description         = "This metric monitors ec2 cpu utilization"
     insufficient_data_actions = []
     dimensions = {
             InstanceId = aws_instance.example_instance.id
     }
     alarm_actions = [aws_sns_topic.sns_example.arn]
}