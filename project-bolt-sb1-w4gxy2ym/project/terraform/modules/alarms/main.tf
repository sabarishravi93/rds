resource "aws_cloudwatch_metric_alarm" "cpu_utilization_writer" {
  alarm_name          = "${var.cluster_identifier}-writer-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.cpu_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.cpu_period
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "Alert when writer CPU exceeds ${var.cpu_threshold}%"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.writer_instance_id
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_readers" {
  count = length(var.reader_instance_ids)

  alarm_name          = "${var.cluster_identifier}-reader-${count.index + 1}-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.cpu_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.cpu_period
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "Alert when reader ${count.index + 1} CPU exceeds ${var.cpu_threshold}%"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.reader_instance_ids[count.index]
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "database_connections" {
  alarm_name          = "${var.cluster_identifier}-database-connections"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.connections_evaluation_periods
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = var.connections_period
  statistic           = "Average"
  threshold           = var.connections_threshold
  alarm_description   = "Alert when database connections exceed ${var.connections_threshold}"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBClusterIdentifier = var.cluster_id
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "replica_lag" {
  count = length(var.reader_instance_ids)

  alarm_name          = "${var.cluster_identifier}-reader-${count.index + 1}-replica-lag"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.replica_lag_evaluation_periods
  metric_name         = "AuroraReplicaLag"
  namespace           = "AWS/RDS"
  period              = var.replica_lag_period
  statistic           = "Average"
  threshold           = var.replica_lag_threshold
  alarm_description   = "Alert when reader ${count.index + 1} replica lag exceeds ${var.replica_lag_threshold}ms"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.reader_instance_ids[count.index]
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "read_latency" {
  alarm_name          = "${var.cluster_identifier}-read-latency"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.read_latency_evaluation_periods
  metric_name         = "ReadLatency"
  namespace           = "AWS/RDS"
  period              = var.read_latency_period
  statistic           = "Average"
  threshold           = var.read_latency_threshold
  alarm_description   = "Alert when read latency exceeds ${var.read_latency_threshold}ms"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBClusterIdentifier = var.cluster_id
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "write_latency" {
  alarm_name          = "${var.cluster_identifier}-write-latency"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.write_latency_evaluation_periods
  metric_name         = "WriteLatency"
  namespace           = "AWS/RDS"
  period              = var.write_latency_period
  statistic           = "Average"
  threshold           = var.write_latency_threshold
  alarm_description   = "Alert when write latency exceeds ${var.write_latency_threshold}ms"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBClusterIdentifier = var.cluster_id
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "freeable_memory_writer" {
  alarm_name          = "${var.cluster_identifier}-writer-freeable-memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.memory_evaluation_periods
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = var.memory_period
  statistic           = "Average"
  threshold           = var.memory_threshold
  alarm_description   = "Alert when writer freeable memory is below ${var.memory_threshold} bytes"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.writer_instance_id
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "freeable_memory_readers" {
  count = length(var.reader_instance_ids)

  alarm_name          = "${var.cluster_identifier}-reader-${count.index + 1}-freeable-memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.memory_evaluation_periods
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = var.memory_period
  statistic           = "Average"
  threshold           = var.memory_threshold
  alarm_description   = "Alert when reader ${count.index + 1} freeable memory is below ${var.memory_threshold} bytes"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.reader_instance_ids[count.index]
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "storage_space" {
  alarm_name          = "${var.cluster_identifier}-low-storage-space"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.storage_evaluation_periods
  metric_name         = "FreeLocalStorage"
  namespace           = "AWS/RDS"
  period              = var.storage_period
  statistic           = "Average"
  threshold           = var.storage_threshold
  alarm_description   = "Alert when free storage space is below ${var.storage_threshold} bytes"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBClusterIdentifier = var.cluster_id
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "deadlocks" {
  alarm_name          = "${var.cluster_identifier}-deadlocks"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.deadlock_evaluation_periods
  metric_name         = "Deadlocks"
  namespace           = "AWS/RDS"
  period              = var.deadlock_period
  statistic           = "Sum"
  threshold           = var.deadlock_threshold
  alarm_description   = "Alert when deadlocks exceed ${var.deadlock_threshold}"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBClusterIdentifier = var.cluster_id
  }

  tags = var.tags
}
