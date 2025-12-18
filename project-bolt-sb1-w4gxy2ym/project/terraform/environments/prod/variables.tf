variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where Aurora cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for Aurora cluster (optional if using data source)"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the database"
  type        = list(string)
  default     = []
}

variable "allowed_security_groups" {
  description = "Security groups allowed to access the database"
  type        = list(string)
  default     = []
}

variable "engine" {
  description = "Aurora database engine"
  type        = string
  default     = "aurora-postgresql"
}

variable "engine_version" {
  description = "Aurora database engine version"
  type        = string
  default     = "15.4"
}

variable "database_name" {
  description = "Name of the default database"
  type        = string
}

variable "master_username" {
  description = "Master username for the database"
  type        = string
  sensitive   = true
}

variable "master_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "database_port" {
  description = "Database port"
  type        = number
  default     = 5432
}

variable "writer_instance_class" {
  description = "Instance class for the writer instance"
  type        = string
  default     = "db.r6g.large"
}

variable "reader_instance_class" {
  description = "Instance class for reader instances"
  type        = string
  default     = "db.r6g.large"
}

variable "reader_count" {
  description = "Number of reader instances"
  type        = number
  default     = 2
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 30
}

variable "preferred_backup_window" {
  description = "Preferred backup window"
  type        = string
  default     = "03:00-04:00"
}

variable "preferred_maintenance_window" {
  description = "Preferred maintenance window"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when destroying"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Apply changes immediately"
  type        = bool
  default     = false
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = true
}

variable "performance_insights_retention_period" {
  description = "Performance Insights retention period in days"
  type        = number
  default     = 7
}

variable "enhanced_monitoring_interval" {
  description = "Enhanced monitoring interval in seconds"
  type        = number
  default     = 60
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch"
  type        = list(string)
  default     = ["postgresql"]
}

variable "parameter_group_family" {
  description = "Parameter group family"
  type        = string
  default     = "aurora-postgresql15"
}

variable "cluster_parameters" {
  description = "Cluster parameters"
  type        = list(map(string))
  default     = []
}

variable "instance_parameters" {
  description = "Instance parameters"
  type        = list(map(string))
  default     = []
}

variable "auto_minor_version_upgrade" {
  description = "Enable auto minor version upgrade"
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Make instances publicly accessible"
  type        = bool
  default     = false
}

variable "alarm_email_addresses" {
  description = "Email addresses for alarm notifications"
  type        = list(string)
}

variable "alarm_phone_numbers" {
  description = "Phone numbers for SMS alarm notifications"
  type        = list(string)
  default     = []
}

variable "cpu_threshold" {
  description = "CPU utilization threshold percentage"
  type        = number
  default     = 80
}

variable "cpu_evaluation_periods" {
  description = "Number of periods to evaluate for CPU alarm"
  type        = number
  default     = 2
}

variable "connections_threshold" {
  description = "Database connections threshold"
  type        = number
  default     = 100
}

variable "connections_evaluation_periods" {
  description = "Number of periods to evaluate for connections alarm"
  type        = number
  default     = 2
}

variable "replica_lag_threshold" {
  description = "Replica lag threshold in milliseconds"
  type        = number
  default     = 1000
}

variable "replica_lag_evaluation_periods" {
  description = "Number of periods to evaluate for replica lag alarm"
  type        = number
  default     = 2
}

variable "read_latency_threshold" {
  description = "Read latency threshold in milliseconds"
  type        = number
  default     = 20
}

variable "read_latency_evaluation_periods" {
  description = "Number of periods to evaluate for read latency alarm"
  type        = number
  default     = 2
}

variable "write_latency_threshold" {
  description = "Write latency threshold in milliseconds"
  type        = number
  default     = 20
}

variable "write_latency_evaluation_periods" {
  description = "Number of periods to evaluate for write latency alarm"
  type        = number
  default     = 2
}

variable "memory_threshold" {
  description = "Freeable memory threshold in bytes"
  type        = number
  default     = 1073741824
}

variable "memory_evaluation_periods" {
  description = "Number of periods to evaluate for memory alarm"
  type        = number
  default     = 2
}

variable "storage_threshold" {
  description = "Free storage threshold in bytes"
  type        = number
  default     = 10737418240
}

variable "storage_evaluation_periods" {
  description = "Number of periods to evaluate for storage alarm"
  type        = number
  default     = 1
}

variable "deadlock_threshold" {
  description = "Deadlock count threshold"
  type        = number
  default     = 5
}

variable "deadlock_evaluation_periods" {
  description = "Number of periods to evaluate for deadlock alarm"
  type        = number
  default     = 1
}
