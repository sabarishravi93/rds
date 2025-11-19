terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.common_tags
  }
}

module "rds" {
  source = "../../modules/rds"

  identifier          = var.db_identifier
  engine              = var.db_engine
  engine_version      = var.db_engine_version
  instance_class      = var.db_instance_class
  allocated_storage   = var.db_allocated_storage
  storage_type        = var.db_storage_type
  storage_encrypted   = var.db_storage_encrypted
  kms_key_id          = var.db_kms_key_id

  database_name       = var.db_name
  master_username     = var.db_master_username
  master_password     = var.db_master_password
  port                = var.db_port

  vpc_id              = var.vpc_id
  subnet_ids          = var.subnet_ids
  allowed_cidr_blocks = var.allowed_cidr_blocks

  backup_retention_period      = var.backup_retention_period
  backup_window                = var.backup_window
  maintenance_window           = var.maintenance_window
  multi_az                     = var.multi_az
  publicly_accessible          = var.publicly_accessible
  skip_final_snapshot          = var.skip_final_snapshot
  final_snapshot_identifier    = var.final_snapshot_identifier
  deletion_protection          = var.deletion_protection
  enabled_cloudwatch_logs      = var.enabled_cloudwatch_logs
  performance_insights_enabled = var.performance_insights_enabled
  monitoring_interval          = var.monitoring_interval

  parameter_group_family = var.parameter_group_family
  parameters             = var.db_parameters

  tags = var.db_tags
}
