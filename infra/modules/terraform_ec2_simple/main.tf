resource "aws_instance" "ec2_instance" {
  ami             = var.ami_id
  instance_type   = "t2.micro"
  key_name        = var.ssh_key_name
  subnet_id       = var.subnet_id
  security_groups = [var.security_group_id]
  tags = var.instance_tags
}

