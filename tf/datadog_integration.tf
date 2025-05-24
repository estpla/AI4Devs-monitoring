# Data source for AWS account ID
data "aws_caller_identity" "current" {}

# Datadog AWS Integration
resource "datadog_integration_aws_account" "datadog_integration" {
  account_tags   = ["env:${var.environment}"]
  aws_account_id = data.aws_caller_identity.current.account_id
  aws_partition  = "aws"
  aws_regions {
    include_all = true
  }
  auth_config {
    aws_auth_config_role {
      role_name   = aws_iam_role.datadog_aws_integration.name
      external_id = var.datadog_external_id
    }
  }
  logs_config {
    lambda_forwarder {}
  }
  metrics_config {
    namespace_filters {}
  }
  resources_config {
    cloud_security_posture_management_collection = true
    extended_collection                          = true
  }
  traces_config {
    xray_services {}
  }
}
