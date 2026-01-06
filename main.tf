provider "aws" {
  region = var.region
}

# GET DEFAULT VPC
data "aws_vpc" "default" {
  default = true
}

# GET ONE SUBNET FROM DEFAULT VPC
data "aws_subnet" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "app_sg" {
  name = "flask-express-sg"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = var.instance_type
  key_name      = var.AKIAUY5PSOQB4WOQYJYI

  subnet_id              = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = file("user-data.sh")

  tags = {
    Name = "flask-express-single-ec2"
  }
}

