aws_region = "us-east-1"

common_tags = {
  Environment = "development"
  Project     = "my-project"
  ManagedBy   = "terraform"
  Team        = "platform"
}

db_identifier        = "myapp-dev-db"
db_engine            = "postgres"
db_engine_version    = "15.4"
db_instance_class    = "db.t3.small"
db_allocated_storage = 50
db_storage_type      = "gp3"
db_storage_encrypted = true

db_name            = "myappdb"
db_master_username = "dbadmin"
db_port            = 5432

vpc_id              = "vpc-dev-xxxxxxxxxxxxxxxxx"
subnet_ids          = ["subnet-dev-xxxxxxxxxxxxxxxxx", "subnet-dev-yyyyyyyyyyyyyyyyy"]
allowed_cidr_blocks = ["10.0.0.0/16"]

backup_retention_period = 3
backup_window           = "02:00-03:00"
maintenance_window      = "sun:03:00-sun:04:00"

multi_az            = false
publicly_accessible = false
skip_final_snapshot = true
deletion_protection = false

enabled_cloudwatch_logs      = ["postgresql"]
performance_insights_enabled = false
monitoring_interval          = 0

parameter_group_family = "postgres15"
db_parameters          = []

db_tags = {
  Database = "primary"
  Tier     = "dev"
}
