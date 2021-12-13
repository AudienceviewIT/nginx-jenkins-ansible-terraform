terraform {
  required_version = "1.0.10"
}

provider "aws" {
    region=var.region
    profile=var.profile
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = "vpc-80dde0f8"

  ingress {
    description      = "ssh from internet"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}  

resource "aws_instance" "rmq" {
    ami = "ami-00f7e5c52c0f43726"
    instance_type="t2.micro"
    key_name="devops"
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
        tags = {
            Name = var.name
            group = var.group
        }
}