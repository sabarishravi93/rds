resource "aws_db_subnet_group" "aurora" {
  name       = "${var.cluster_identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_identifier}-subnet-group"
    }
  )
}

resource "aws_security_group" "aurora" {
  name_description = "Security group for ${var.cluster_identifier} Aurora cluster"
  vpc_id          = var.vpc_id

  ingress {
    from_port       = var.port
    to_port         = var.port
    protocol        = "tcp"
    cidr_blocks     = var.allowed_cidr_blocks
    security_groups = var.allowed_security_groups
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_identifier}-sg"
    }
  )
}

resource "aws_kms_key" "aurora" {
  description             = "KMS key for ${var.cluster_identifier} Aurora cluster encryption"
  deletion_window_in_days = var.kms_deletion_window
  enable_key_rotation     = true

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_identifier}-kms-key"
    }
  )
}

resource "aws_kms_alias" "aurora" {
  name          = "alias/${var.cluster_identifier}-aurora"
  target_key_id = aws_kms_key.aurora.key_id
}

resource "aws_rds_cluster_parameter_group" "aurora" {
  name        = "${var.cluster_identifier}-cluster-pg"
  family      = var.parameter_group_family
  description = "Cluster parameter group for ${var.cluster_identifier}"

  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }

  tags = var.tags
}

resource "aws_db_parameter_group" "aurora" {
  name        = "${var.cluster_identifier}-instance-pg"
  family      = var.parameter_group_family
  description = "Instance parameter group for ${var.cluster_identifier}"

  dynamic "parameter" {
    for_each = var.instance_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", "immediate")
    }
  }

  tags = var.tags
}

resource "aws_iam_role" "enhanced_monitoring" {
  name               = "${var.cluster_identifier}-enhanced-monitoring"
  assume_role_policy = data.aws_iam_policy_document.enhanced_monitoring.json

  tags = var.tags
}

data "aws_iam_policy_document" "enhanced_monitoring" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  role       = aws_iam_role.enhanced_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier              = var.cluster_identifier
  engine                          = var.engine
  engine_version                  = var.engine_version
  engine_mode                     = "provisioned"
  database_name                   = var.database_name
  master_username                 = var.master_username
  master_password                 = var.master_password
  port                            = var.port

  db_subnet_group_name            = aws_db_subnet_group.aurora.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora.name
  vpc_security_group_ids          = [aws_security_group.aurora.id]

  storage_encrypted               = true
  kms_key_id                      = aws_kms_key.aurora.arn

  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  deletion_protection             = var.deletion_protection
  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = var.skip_final_snapshot ? null : "${var.cluster_identifier}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  apply_immediately               = var.apply_immediately

  tags = merge(
    var.tags,
    {
      Name = var.cluster_identifier
    }
  )

  lifecycle {
    ignore_changes = [
      master_password,
      final_snapshot_identifier
    ]
  }
}

resource "aws_rds_cluster_instance" "writer" {
  identifier                   = "${var.cluster_identifier}-writer"
  cluster_identifier           = aws_rds_cluster.aurora.id
  instance_class               = var.writer_instance_class
  engine                       = aws_rds_cluster.aurora.engine
  engine_version               = aws_rds_cluster.aurora.engine_version

  db_parameter_group_name      = aws_db_parameter_group.aurora.name

  performance_insights_enabled = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_enabled ? aws_kms_key.aurora.arn : null
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null

  monitoring_interval          = var.enhanced_monitoring_interval
  monitoring_role_arn          = var.enhanced_monitoring_interval > 0 ? aws_iam_role.enhanced_monitoring.arn : null

  auto_minor_version_upgrade   = var.auto_minor_version_upgrade

  publicly_accessible          = var.publicly_accessible

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_identifier}-writer"
      Role = "writer"
    }
  )
}

resource "aws_rds_cluster_instance" "readers" {
  count = var.reader_count

  identifier                   = "${var.cluster_identifier}-reader-${count.index + 1}"
  cluster_identifier           = aws_rds_cluster.aurora.id
  instance_class               = var.reader_instance_class
  engine                       = aws_rds_cluster.aurora.engine
  engine_version               = aws_rds_cluster.aurora.engine_version

  db_parameter_group_name      = aws_db_parameter_group.aurora.name

  performance_insights_enabled = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_enabled ? aws_kms_key.aurora.arn : null
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null

  monitoring_interval          = var.enhanced_monitoring_interval
  monitoring_role_arn          = var.enhanced_monitoring_interval > 0 ? aws_iam_role.enhanced_monitoring.arn : null

  auto_minor_version_upgrade   = var.auto_minor_version_upgrade

  publicly_accessible          = var.publicly_accessible

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_identifier}-reader-${count.index + 1}"
      Role = "reader"
    }
  )
}
