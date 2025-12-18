variable "topic_name" {
  description = "Name of the SNS topic"
  type        = string
}

variable "display_name" {
  description = "Display name for the SNS topic"
  type        = string
  default     = ""
}

variable "email_addresses" {
  description = "List of email addresses to subscribe to the topic"
  type        = list(string)
  default     = []
}

variable "phone_numbers" {
  description = "List of phone numbers to subscribe to the topic (format: +1234567890)"
  type        = list(string)
  default     = []
}

variable "kms_master_key_id" {
  description = "KMS key ID for SNS topic encryption"
  type        = string
  default     = null
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "tags" {
  description = "Tags to apply to SNS resources"
  type        = map(string)
  default     = {}
}
