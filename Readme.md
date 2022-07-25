## Terraform aws s3 backend

This project demonsytrates the process of storing the "fault/terraform.tfstate" files into the s3 bucket as backend

during the creation of an instance

## Pre-requisite
•	Install terraform v1.0.0
•	Setup the aws cli credentials with default profile name.
## Setup
1.	Apply the remote_state terraform project. This will create s3 bucket and lock table 

terraform {

  backend "s3" {
  
    bucket = "aws1bucketone"
    
    key    = "fault/terraform.tfstate"
    
    region = "eu-west-2"
  }

}
3.	### Create the ec2 instance and all its components

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
