output "cpu_alarm_ids" {
  description = "CloudWatch alarm IDs for CPU utilization"
  value = concat(
    [aws_cloudwatch_metric_alarm.cpu_utilization_writer.id],
    aws_cloudwatch_metric_alarm.cpu_utilization_readers[*].id
  )
}

output "connection_alarm_id" {
  description = "CloudWatch alarm ID for database connections"
  value       = aws_cloudwatch_metric_alarm.database_connections.id
}

output "replica_lag_alarm_ids" {
  description = "CloudWatch alarm IDs for replica lag"
  value       = aws_cloudwatch_metric_alarm.replica_lag[*].id
}

output "latency_alarm_ids" {
  description = "CloudWatch alarm IDs for latency"
  value = [
    aws_cloudwatch_metric_alarm.read_latency.id,
    aws_cloudwatch_metric_alarm.write_latency.id
  ]
}

output "memory_alarm_ids" {
  description = "CloudWatch alarm IDs for memory"
  value = concat(
    [aws_cloudwatch_metric_alarm.freeable_memory_writer.id],
    aws_cloudwatch_metric_alarm.freeable_memory_readers[*].id
  )
}

output "storage_alarm_id" {
  description = "CloudWatch alarm ID for storage"
  value       = aws_cloudwatch_metric_alarm.storage_space.id
}

output "deadlock_alarm_id" {
  description = "CloudWatch alarm ID for deadlocks"
  value       = aws_cloudwatch_metric_alarm.deadlocks.id
}
