terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }

  required_version = ">= 1.2.0"

  cloud {
    organization = "spatkiorg"

    workspaces {
      name = "awsLab"
    }
  }
}

provider "aws" {
  region = "us-east-1c"
}

resource "aws_security_group" "awsLab_sc1" {
  name        = "awsLab_sc1"
  description = "Allow HTTP and SSH traffic via Terraform"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "app_server" {
  ami                         = "ami-007855ac798b5175e"
  instance_type               = "t3.micro"
  key_name                    = "keyforlab"
  vpc_security_group_ids      = [aws_security_group.awsLab_sc1.id]
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")
  tags = {
    Name = "awsLab"
  }
}