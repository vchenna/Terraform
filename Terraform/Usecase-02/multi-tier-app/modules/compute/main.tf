resource "aws_instance" "web" {
  ami           = var.web_ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  security_groups = [var.web_sg_id]
  tags = { Name = "web-server" }
}

resource "aws_instance" "app" {
  ami           = var.app_ami
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  security_groups = [var.app_sg_id]
  tags = { Name = "app-server" }
}
