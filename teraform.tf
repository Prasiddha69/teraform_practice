terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }
  required_version = ">= 1.2.0"
}

# Creating Security Group
resource "aws_security_group" "my_tc_security" {
  name        = "my security group"
  description = "Allow inbound SSH, HTTP, HTTPS, and custom ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
}

# Creating AWS Instance
resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-09040d770ffe2224f"
  instance_type = "t2.micro"

  key_name = "my-test-key"

  security_groups = [aws_security_group.my_tc_security.name]

  tags = {
    Name = "Ec2_Server"
  }

#   lifecycle {
#     prevent_destroy = true
#   }
}

# Getting Public IPs as Output
output "ec2_public_ips" {
  value = aws_instance.my_ec2_instance.public_ip
}