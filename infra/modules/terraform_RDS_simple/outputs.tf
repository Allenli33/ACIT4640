output "rds_instance_endpoint" {
  description = "The connection endpoint for the RDS instance."
  value       = aws_db_instance.a03_rds.endpoint
}

output "rds_address" {
  value       = aws_db_instance.a03_rds.address
}

output "rds_instance_id" {
  description = "The ID of the RDS instance."
  value       = aws_db_instance.a03_rds.id
}

# Depending on your needs, you might also want to output the RDS instance ARN, the database name, or username.
output "rds_instance_arn" {
  description = "The ARN of the RDS instance."
  value       = aws_db_instance.a03_rds.arn
}
