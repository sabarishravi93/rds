output "cluster_endpoint" {
  description = "Writer endpoint for the Aurora cluster"
  value       = module.aurora.cluster_endpoint
}

output "reader_endpoint" {
  description = "Reader endpoint for the Aurora cluster"
  value       = module.aurora.reader_endpoint
}

output "cluster_port" {
  description = "Port for the Aurora cluster"
  value       = module.aurora.cluster_port
}

output "database_name" {
  description = "Name of the default database"
  value       = module.aurora.database_name
}

output "master_username" {
  description = "Master username for the database"
  value       = module.aurora.master_username
  sensitive   = true
}

output "cluster_id" {
  description = "Aurora cluster ID"
  value       = module.aurora.cluster_id
}

output "cluster_arn" {
  description = "Aurora cluster ARN"
  value       = module.aurora.cluster_arn
}

output "writer_instance_id" {
  description = "Writer instance ID"
  value       = module.aurora.writer_instance_id
}

output "reader_instance_ids" {
  description = "Reader instance IDs"
  value       = module.aurora.reader_instance_ids
}

output "security_group_id" {
  description = "Security group ID for the Aurora cluster"
  value       = module.aurora.security_group_id
}

output "kms_key_id" {
  description = "KMS key ID for encryption"
  value       = module.aurora.kms_key_id
}

output "kms_key_arn" {
  description = "KMS key ARN for encryption"
  value       = module.aurora.kms_key_arn
}

output "sns_topic_arn" {
  description = "SNS topic ARN for alarm notifications"
  value       = module.sns_alarms.topic_arn
}

output "sns_topic_name" {
  description = "SNS topic name for alarm notifications"
  value       = module.sns_alarms.topic_name
}

output "alarm_ids" {
  description = "All CloudWatch alarm IDs"
  value = {
    cpu_alarms          = module.alarms.cpu_alarm_ids
    connection_alarm    = module.alarms.connection_alarm_id
    replica_lag_alarms  = module.alarms.replica_lag_alarm_ids
    latency_alarms      = module.alarms.latency_alarm_ids
    memory_alarms       = module.alarms.memory_alarm_ids
    storage_alarm       = module.alarms.storage_alarm_id
    deadlock_alarm      = module.alarms.deadlock_alarm_id
  }
}

output "connection_string" {
  description = "Database connection string for applications"
  value       = "postgresql://${module.aurora.master_username}:****@${module.aurora.cluster_endpoint}:${module.aurora.cluster_port}/${module.aurora.database_name}"
  sensitive   = false
}

output "reader_connection_string" {
  description = "Database connection string for read-only applications"
  value       = "postgresql://${module.aurora.master_username}:****@${module.aurora.reader_endpoint}:${module.aurora.cluster_port}/${module.aurora.database_name}"
  sensitive   = false
}
