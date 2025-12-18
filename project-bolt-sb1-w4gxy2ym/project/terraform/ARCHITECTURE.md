# Aurora Terraform Architecture

## Overview

This Terraform project implements a production-grade Amazon Aurora PostgreSQL cluster with comprehensive monitoring and alerting capabilities.

## Architecture Principles

### 1. Modularity

The project is organized into reusable modules:

- **aurora**: Provisions the Aurora cluster, instances, and related resources
- **alarms**: Creates CloudWatch alarms for monitoring
- **sns**: Sets up notification channels for alerts

This modular approach enables:
- Code reusability across environments
- Team autonomy (separate teams can manage different modules)
- Easier testing and maintenance
- Clear separation of concerns

### 2. Environment Separation

Environments (dev, staging, prod) are separated in the `environments/` directory:

```
environments/
├── prod/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── staging/
└── dev/
```

Each environment can have different:
- Instance sizes
- Number of replicas
- Alarm thresholds
- Backup retention periods

### 3. Team Autonomy

The architecture supports separate teams managing different aspects:

**Database Team** manages:
- Aurora module (`modules/aurora/`)
- Database configurations
- Parameter groups
- Security groups

**Application Team** uses:
- Environment configurations (`environments/*/`)
- Connection endpoints (from outputs)
- Can deploy independently by referencing stable module versions

**Operations Team** manages:
- Alarms module (`modules/alarms/`)
- SNS module (`modules/sns/`)
- Monitoring thresholds
- Notification channels

## Components

### Aurora Module

Provisions:
- RDS Aurora cluster (writer + readers)
- KMS encryption keys
- Security groups
- IAM roles for enhanced monitoring
- Parameter groups (cluster and instance level)
- CloudWatch log exports

### Alarms Module

Creates CloudWatch alarms for:
- **CPU Utilization**: Monitors all instances (writer + readers)
- **Database Connections**: Tracks active connections
- **Replica Lag**: Monitors replication delay on readers
- **Read/Write Latency**: Tracks query performance
- **Memory**: Monitors freeable memory
- **Storage**: Tracks available storage space
- **Deadlocks**: Detects database deadlock situations

### SNS Module

Manages:
- SNS topic for alarm notifications
- Email subscriptions
- SMS subscriptions (optional)
- IAM policies for CloudWatch integration

## Enterprise Features

### Security

1. **Encryption at Rest**: KMS-encrypted storage with automatic key rotation
2. **Encryption in Transit**: SSL/TLS connections (configured in parameter groups)
3. **Network Isolation**: VPC security groups and subnet groups
4. **IAM Authentication**: Support for IAM database authentication
5. **Secret Management**: Sensitive variables marked as sensitive

### High Availability

1. **Multi-AZ Deployment**: Instances spread across availability zones
2. **Automated Failover**: Aurora handles writer failover automatically
3. **Read Replicas**: Scale read capacity with multiple reader instances
4. **Deletion Protection**: Prevents accidental cluster deletion

### Backup & Recovery

1. **Automated Backups**: Configurable retention (default: 30 days)
2. **Point-in-Time Recovery**: Restore to any second within retention period
3. **Final Snapshots**: Automatic snapshot on cluster deletion
4. **Cross-Region Replication**: Can be added via additional configuration

### Monitoring & Observability

1. **CloudWatch Metrics**: Automatic metric collection
2. **Performance Insights**: Deep database performance analysis
3. **Enhanced Monitoring**: OS-level metrics (CPU, memory, disk)
4. **CloudWatch Logs**: PostgreSQL logs exported to CloudWatch
5. **Custom Alarms**: Configurable thresholds for key metrics

### Operational Excellence

1. **Tagging Strategy**: Consistent tags across all resources
2. **Maintenance Windows**: Scheduled maintenance during low-traffic periods
3. **Backup Windows**: Automated backups during off-peak hours
4. **Auto Minor Version Upgrades**: Automatic security patches
5. **Parameter Management**: Centralized database configuration

## Workflow

### Initial Deployment

1. Copy `terraform.tfvars.example` to `terraform.tfvars`
2. Update variables with your values
3. Initialize Terraform: `terraform init`
4. Plan deployment: `terraform plan`
5. Apply changes: `terraform apply`
6. Confirm SNS email subscriptions

### Making Changes

1. Update variables or module code
2. Run `terraform plan` to preview changes
3. Review the plan carefully
4. Apply with `terraform apply`

### Adding a New Environment

1. Create new directory in `environments/`
2. Copy configuration from existing environment
3. Customize variables for new environment
4. Initialize and apply

## Scaling Considerations

### Vertical Scaling

Change instance classes:
```hcl
writer_instance_class = "db.r6g.xlarge"
reader_instance_class = "db.r6g.xlarge"
```

### Horizontal Scaling

Add more readers:
```hcl
reader_count = 3
```

### Storage Scaling

Aurora automatically scales storage (no configuration needed)

## Cost Optimization

1. **Right-sizing**: Start with smaller instances and scale up
2. **Reader Replicas**: Only provision what you need
3. **Backup Retention**: Balance compliance needs with storage costs
4. **Performance Insights**: 7-day retention is free; longer retention incurs costs
5. **Enhanced Monitoring**: Consider reducing interval to 300s for non-critical environments

## Security Best Practices

1. **Never commit** `terraform.tfvars` with real credentials
2. **Use** AWS Secrets Manager or SSM Parameter Store for passwords
3. **Enable** deletion protection in production
4. **Rotate** database credentials regularly
5. **Review** security group rules regularly
6. **Enable** AWS CloudTrail for audit logging
7. **Use** least privilege IAM policies

## Disaster Recovery

### Backup Strategy

- **Automated Backups**: Daily backups retained for 30 days
- **Manual Snapshots**: Create before major changes
- **Cross-Region Backup**: Consider for critical workloads

### Recovery Scenarios

1. **Point-in-Time Recovery**: Restore from automated backup
2. **Snapshot Restore**: Create new cluster from snapshot
3. **Regional Failure**: Use cross-region replica (if configured)

### Testing Recovery

Regularly test:
- Snapshot restoration
- Point-in-time recovery
- Failover procedures
- Backup integrity

## Troubleshooting

### Common Issues

1. **Insufficient Subnet Coverage**: Ensure subnets span multiple AZs
2. **Security Group Rules**: Verify allowed CIDR blocks and security groups
3. **Parameter Conflicts**: Check parameter compatibility with engine version
4. **KMS Permissions**: Ensure IAM permissions for KMS key usage

### Monitoring Alarms

Check CloudWatch console for:
- Alarm states (OK, ALARM, INSUFFICIENT_DATA)
- Alarm history
- Metric graphs

## Future Enhancements

Potential additions:
1. Cross-region read replicas
2. Aurora Global Database
3. AWS Backup integration
4. Database activity streams
5. Query monitoring and slow query logging
6. Automated scaling with Application Auto Scaling
7. Blue/green deployments
8. Custom CloudWatch dashboards
