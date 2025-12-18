variable "cluster_identifier" {
  description = "Aurora cluster identifier"
  type        = string
}

variable "cluster_id" {
  description = "Aurora cluster ID"
  type        = string
}

variable "writer_instance_id" {
  description = "Writer instance ID"
  type        = string
}

variable "reader_instance_ids" {
  description = "List of reader instance IDs"
  type        = list(string)
  default     = []
}

variable "sns_topic_arn" {
  description = "SNS topic ARN for alarm notifications"
  type        = string
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

variable "cpu_period" {
  description = "Period in seconds for CPU metric"
  type        = number
  default     = 300
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

variable "connections_period" {
  description = "Period in seconds for connections metric"
  type        = number
  default     = 300
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

variable "replica_lag_period" {
  description = "Period in seconds for replica lag metric"
  type        = number
  default     = 60
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

variable "read_latency_period" {
  description = "Period in seconds for read latency metric"
  type        = number
  default     = 300
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

variable "write_latency_period" {
  description = "Period in seconds for write latency metric"
  type        = number
  default     = 300
}

variable "memory_threshold" {
  description = "Freeable memory threshold in bytes (default: 1GB)"
  type        = number
  default     = 1073741824
}

variable "memory_evaluation_periods" {
  description = "Number of periods to evaluate for memory alarm"
  type        = number
  default     = 2
}

variable "memory_period" {
  description = "Period in seconds for memory metric"
  type        = number
  default     = 300
}

variable "storage_threshold" {
  description = "Free storage threshold in bytes (default: 10GB)"
  type        = number
  default     = 10737418240
}

variable "storage_evaluation_periods" {
  description = "Number of periods to evaluate for storage alarm"
  type        = number
  default     = 1
}

variable "storage_period" {
  description = "Period in seconds for storage metric"
  type        = number
  default     = 300
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

variable "deadlock_period" {
  description = "Period in seconds for deadlock metric"
  type        = number
  default     = 300
}

variable "tags" {
  description = "Tags to apply to all alarm resources"
  type        = map(string)
  default     = {}
}
