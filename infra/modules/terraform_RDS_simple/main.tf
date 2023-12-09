resource "aws_db_subnet_group" "sn_group" {
  name       = "a03_sng"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}



resource "aws_db_instance" "a03_rds" {
  identifier           = var.identifier
  allocated_storage    = var.allocated_storage
  username             = var.username
  password             = var.password
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.db_instance_class
  vpc_security_group_ids = var.sg_ids
  db_subnet_group_name = aws_db_subnet_group.sn_group.name
  skip_final_snapshot  = true
}