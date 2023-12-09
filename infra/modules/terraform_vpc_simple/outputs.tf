output "vpc_id" {
  value = aws_vpc.a03_vpc.id
}

output "web_subnet_id" {
  value = aws_subnet.web.id
}

output "be_subnet_id" {
  value = aws_subnet.be.id
}

output "db_1_subnet_id" {
  value = aws_subnet.db_1.id
}

output "db_2_subnet_id" {
  value = aws_subnet.db_2.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.gw_a03.id
}

output "route_table_id" {
  value = aws_route_table.rt_a03.id
}

output "be_subnet_cidr" {
  description = "The CIDR block for the backend subnet"
  value       = aws_subnet.be.cidr_block
}
