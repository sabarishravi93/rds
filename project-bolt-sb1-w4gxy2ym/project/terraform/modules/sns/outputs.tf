output "topic_arn" {
  description = "ARN of the SNS topic"
  value       = aws_sns_topic.alarms.arn
}

output "topic_id" {
  description = "ID of the SNS topic"
  value       = aws_sns_topic.alarms.id
}

output "topic_name" {
  description = "Name of the SNS topic"
  value       = aws_sns_topic.alarms.name
}
