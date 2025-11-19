terraform {
  backend "s3" {
    bucket         = "my-terraform-state-dev"
    key            = "rds/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock-dev"
  }
}
