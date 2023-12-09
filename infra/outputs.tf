output "vpc_id" {
  value = module.vpc.vpc_id
}

output "web_subnet_id" {
  value = module.vpc.web_subnet_id
}

output "be_subnet_id" {
  value = module.vpc.be_subnet_id
}

output "db_1_subnet_id" {
  value = module.vpc.db_1_subnet_id
}

output "db_2_subnet_id" {
  value = module.vpc.db_2_subnet_id
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "route_table_id" {
  value = module.vpc.route_table_id
}

output "sg_web_id" {
  description = "The ID of the web security group"
  value       = module.sg_web.sg_id  
}

output "sg_be_id" {
  description = "The ID of the backend security group"
  value       = module.sg_be.sg_id  
}

output "sg_db_id" {
  description = "The ID of the database security group"
  value       = module.sg_db.sg_id  
}



# For web EC2 instance
output "web_ec2_instance_id" {
  value = module.web_ec2.ec2_instance_id
}

output "web_ec2_instance_public_ip" {
  value = module.web_ec2.ec2_instance_public_ip
}

output "web_ec2_instance_public_dns" {
  value = module.web_ec2.ec2_instance_public_dns
}

# For backend EC2 instance
output "be_ec2_instance_id" {
  value = module.be_ec2.ec2_instance_id
}

output "be_ec2_instance_public_ip" {
  value = module.be_ec2.ec2_instance_public_ip
}

output "be_ec2_instance_public_dns" {
  value = module.be_ec2.ec2_instance_public_dns
}

# rds instance
output "my_rds_endpoint" {
  value = module.rds.rds_instance_endpoint
}

output "my_rds_address" {
  value = module.rds.rds_address
}

output "my_rds_instance_id" {
  value = module.rds.rds_instance_id
}

output "my_rds_instance_arn" {
  value = module.rds.rds_instance_arn
}

