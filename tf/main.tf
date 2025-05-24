# Main configuration file
# This file serves as the entry point for the Terraform configuration
# All resources are defined in their respective files:
# - provider.tf: Provider configurations
# - variables.tf: Variable definitions
# - ec2.tf: EC2 instances
# - iam.tf: IAM roles and policies
# - security_groups.tf: Security groups
# - s3.tf: S3 bucket and objects
# - datadog_integration.tf: Datadog integration
# - datadog_dashboard.tf: Datadog dashboard
# - datadog_monitor.tf: Datadog monitors
# - outputs.tf: Output values

locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}