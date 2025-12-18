# Aurora Database Infrastructure

This Terraform project provisions an Amazon Aurora PostgreSQL cluster with enterprise-grade features.

## Structure

```
terraform/
├── modules/
│   ├── aurora/           # Aurora cluster module
│   ├── alarms/           # CloudWatch alarms module
│   └── sns/              # SNS notifications module
├── environments/
│   └── prod/             # Production environment
└── README.md
```

## Features

- Aurora PostgreSQL cluster with configurable writer and reader instances
- Encryption at rest using AWS KMS
- Deletion protection and automated backups
- Performance Insights and Enhanced Monitoring
- CloudWatch alarms for key metrics (CPU, connections, replica lag, latency)
- SNS notifications for alarm events
- Comprehensive tagging strategy

## Usage

### Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0

### Deploy Production Environment

```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

### Customize Variables

Edit `environments/prod/terraform.tfvars` to customize:
- Instance classes
- Number of reader instances
- Alarm thresholds
- Backup retention periods
- Email addresses for notifications

## Module Documentation

### Aurora Module (`modules/aurora`)

Provisions an Aurora cluster with encryption, monitoring, and backup capabilities.

### Alarms Module (`modules/alarms`)

Creates CloudWatch alarms for monitoring Aurora cluster health and performance.

### SNS Module (`modules/sns`)

Sets up SNS topics and email subscriptions for alarm notifications.
