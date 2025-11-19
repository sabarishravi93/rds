variable "identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
}

variable "engine" {
  description = "Database engine type"
  type        = string
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
}

variable "instance_class" {
  description = "Instance class for the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in gigabytes"
  type        = number
}

variable "max_allocated_storage" {
  description = "Maximum allocated storage for autoscaling"
  type        = number
  default     = 0
}

variable "storage_type" {
  description = "Storage type for the RDS instance"
  type        = string
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
}

variable "kms_key_id" {
  description = "KMS key ID for storage encryption"
  type        = string
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

variable "port" {
  description = "Port for the database"
  type        = number
}

variable "vpc_id" {
  description = "VPC ID where the RDS instance will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the database"
  type        = list(string)
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
}

variable "backup_window" {
  description = "Preferred backup window"
  type        = string
}

variable "maintenance_window" {
  description = "Preferred maintenance window"
  type        = string
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
}

variable "publicly_accessible" {
  description = "Allow public access to the database"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on deletion"
  type        = bool
}

variable "final_snapshot_identifier" {
  description = "Identifier for the final snapshot"
  type        = string
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
}

variable "enabled_cloudwatch_logs" {
  description = "List of log types to enable for CloudWatch"
  type        = list(string)
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
}

variable "monitoring_interval" {
  description = "Enhanced monitoring interval in seconds"
  type        = number
}

variable "parameter_group_family" {
  description = "Database parameter group family"
  type        = string
}

variable "parameters" {
  description = "Database parameters"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "auto_minor_version_upgrade" {
  description = "Enable automatic minor version upgrades"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Apply changes immediately"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
