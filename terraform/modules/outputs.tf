output "db_instance_id" {
  description = "RDS instance identifier"
  value       = module.rds.db_instance_id
}

output "db_instance_arn" {
  description = "ARN of the RDS instance"
  value       = module.rds.db_instance_arn
}

output "db_instance_endpoint" {
  description = "Connection endpoint for the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "db_instance_address" {
  description = "Address of the RDS instance"
  value       = module.rds.db_instance_address
}

output "db_instance_port" {
  description = "Port of the RDS instance"
  value       = module.rds.db_instance_port
}

output "db_name" {
  description = "Name of the database"
  value       = module.rds.db_name
}

output "db_security_group_id" {
  description = "Security group ID attached to the RDS instance"
  value       = module.rds.db_security_group_id
}

output "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = module.rds.db_subnet_group_name
}

output "db_parameter_group_name" {
  description = "Name of the DB parameter group"
  value       = module.rds.db_parameter_group_name
}
