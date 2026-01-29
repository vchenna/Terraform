provider "aws" {
  region = var.region
}

resource "aws_security_group" "example" {
  name        = "terraform-sg"
  description = "Security group for Terraform EC2 instance"

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

  tags = {
    Name = "Terraform-SG"
  }
}

resource "aws_instance" "example" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "aws_east_keypair"
  vpc_security_group_ids = [aws_security_group.example.id]

  tags = {
    Name = "Terraform-EC2"
  }
}