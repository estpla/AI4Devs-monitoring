variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "datadog_api_key" {
  description = "Datadog API key for authentication"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "Datadog Application key for advanced API access"
  type        = string
  sensitive   = true
}

variable "datadog_site" {
  description = "Datadog site URL (datadoghq.eu for EU users)"
  type        = string
  default     = "datadoghq.eu"
}

variable "ec2_instance_type_backend" {
  description = "EC2 instance type for backend server"
  type        = string
  default     = "t2.micro"
}

variable "ec2_instance_type_frontend" {
  description = "EC2 instance type for frontend server"
  type        = string
  default     = "t2.micro"
}

variable "project_name" {
  description = "Name of the project for resource naming and tagging"
  type        = string
  default     = "lti-project"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "datadog_external_id" {
  description = "External ID for Datadog AWS integration role"
  type        = string
  default     = "datadog-aws-integration"
}
