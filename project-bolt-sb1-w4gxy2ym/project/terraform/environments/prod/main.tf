terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # Configure your S3 backend here
    # bucket         = "your-terraform-state-bucket"
    # key            = "prod/aurora/terraform.tfstate"
    # region         = "us-east-1"
    # dynamodb_table = "terraform-state-lock"
    # encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "database" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Tier = "Database"
  }
}

module "sns_alarms" {
  source = "../../modules/sns"

  topic_name        = "${var.project_name}-${var.environment}-aurora-alarms"
  display_name      = "Aurora Database Alarms - ${var.environment}"
  email_addresses   = var.alarm_email_addresses
  phone_numbers     = var.alarm_phone_numbers
  aws_account_id    = data.aws_caller_identity.current.account_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-aurora-alarms"
    Environment = var.environment
  }
}

module "aurora" {
  source = "../../modules/aurora"

  cluster_identifier = "${var.project_name}-${var.environment}"
  engine             = var.engine
  engine_version     = var.engine_version
  database_name      = var.database_name
  master_username    = var.master_username
  master_password    = var.master_password
  port               = var.database_port

  vpc_id                    = var.vpc_id
  subnet_ids                = length(var.subnet_ids) > 0 ? var.subnet_ids : data.aws_subnets.database.ids
  allowed_cidr_blocks       = var.allowed_cidr_blocks
  allowed_security_groups   = var.allowed_security_groups

  writer_instance_class = var.writer_instance_class
  reader_instance_class = var.reader_instance_class
  reader_count          = var.reader_count

  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window

  deletion_protection  = var.deletion_protection
  skip_final_snapshot  = var.skip_final_snapshot
  apply_immediately    = var.apply_immediately

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  enhanced_monitoring_interval          = var.enhanced_monitoring_interval

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  parameter_group_family = var.parameter_group_family
  cluster_parameters     = var.cluster_parameters
  instance_parameters    = var.instance_parameters

  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  publicly_accessible        = var.publicly_accessible

  tags = {
    Name        = "${var.project_name}-${var.environment}-aurora"
    Environment = var.environment
  }
}

module "alarms" {
  source = "../../modules/alarms"

  cluster_identifier  = module.aurora.cluster_id
  cluster_id          = module.aurora.cluster_id
  writer_instance_id  = module.aurora.writer_instance_id
  reader_instance_ids = module.aurora.reader_instance_ids
  sns_topic_arn       = module.sns_alarms.topic_arn

  cpu_threshold                     = var.cpu_threshold
  cpu_evaluation_periods            = var.cpu_evaluation_periods
  connections_threshold             = var.connections_threshold
  connections_evaluation_periods    = var.connections_evaluation_periods
  replica_lag_threshold             = var.replica_lag_threshold
  replica_lag_evaluation_periods    = var.replica_lag_evaluation_periods
  read_latency_threshold            = var.read_latency_threshold
  read_latency_evaluation_periods   = var.read_latency_evaluation_periods
  write_latency_threshold           = var.write_latency_threshold
  write_latency_evaluation_periods  = var.write_latency_evaluation_periods
  memory_threshold                  = var.memory_threshold
  memory_evaluation_periods         = var.memory_evaluation_periods
  storage_threshold                 = var.storage_threshold
  storage_evaluation_periods        = var.storage_evaluation_periods
  deadlock_threshold                = var.deadlock_threshold
  deadlock_evaluation_periods       = var.deadlock_evaluation_periods

  tags = {
    Name        = "${var.project_name}-${var.environment}-alarms"
    Environment = var.environment
  }
}
