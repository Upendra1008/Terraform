resource "aws_instance" "webserver" {

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name        = "Terraform-EC2"
    Environment = "Dev"
    Owner       = "Debdip"
  }
}
