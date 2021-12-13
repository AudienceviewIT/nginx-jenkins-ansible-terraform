terraform {
  required_version = "1.0.10"
}

provider "aws" {
    region=var.region
    profile=var.profile
}

resource "aws_instance" "rmq" {
    ami = "ami-00f7e5c52c0f43726"
    instance_type="t2.micro"
    key_name="devops"
    vpc_security_group_ids = "sg-ff0a63cd"
        tags = {
            Name = var.name
            group = var.group
        }