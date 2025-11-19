aws_region = "us-east-1"

common_tags = {
  Environment = "sit"
  Project     = "my-project"
  ManagedBy   = "terraform"
  Team        = "platform"
}

db_identifier        = "myapp-sit-db"
db_engine            = "postgres"
db_engine_version    = "15.4"
db_instance_class    = "db.t3.medium"
db_allocated_storage = 75
db_storage_type      = "gp3"
db_storage_encrypted = true

db_name            = "myappdb"
db_master_username = "dbadmin"
db_port            = 5432

vpc_id              = "vpc-sit-xxxxxxxxxxxxxxxxx"
subnet_ids          = ["subnet-sit-xxxxxxxxxxxxxxxxx", "subnet-sit-yyyyyyyyyyyyyyyyy"]
allowed_cidr_blocks = ["10.1.0.0/16"]

backup_retention_period = 5
backup_window           = "02:30-03:30"
maintenance_window      = "sun:03:30-sun:04:30"

multi_az            = true
publicly_accessible = false
skip_final_snapshot = false
deletion_protection = true

enabled_cloudwatch_logs      = ["postgresql"]
performance_insights_enabled = true
monitoring_interval          = 60

parameter_group_family = "postgres15"
db_parameters = [
  {
    name  = "shared_preload_libraries"
    value = "pg_stat_statements"
  }
]

db_tags = {
  Database = "primary"
  Tier     = "sit"
}
