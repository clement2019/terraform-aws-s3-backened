
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}




provider "aws" {
  #uncomment the folowing and replace with your keys

  profile = "myaws"

  region = var.region
  #profile ="default"


}

resource "aws_instance" "aws1_example" {
  ami           = var.ami
  instance_type = "t2.micro"

  tags = {
    Name = "Servermachine"
  }
}

resource "aws_instance" "ayenco_example" {
  ami           = var.ami
  instance_type = "t2.micro"

  tags = {
    Name = "aws_machine"
  }



}
resource "aws_instance" "web-server" {
  ami           = var.ami
  instance_type = "t2.micro"
  # key_name               = var.ec2-key
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  tags = {
    Name = "terraform-web-server"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh traffic"


  ingress {

    from_port = 22 #
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
}
