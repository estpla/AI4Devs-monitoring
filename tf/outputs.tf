output "backend_instance_id" {
  description = "ID of the backend EC2 instance"
  value       = aws_instance.backend.id
}

output "frontend_instance_id" {
  description = "ID of the frontend EC2 instance"
  value       = aws_instance.frontend.id
}

output "backend_public_ip" {
  description = "Public IP address of the backend instance"
  value       = aws_instance.backend.public_ip
}

output "frontend_public_ip" {
  description = "Public IP address of the frontend instance"
  value       = aws_instance.frontend.public_ip
}

output "datadog_dashboard_url" {
  description = "URL to the Datadog dashboard"
  value       = "https://app.${var.datadog_site}/dashboard/${datadog_dashboard.aws_infrastructure.id}"
}

output "datadog_integration_external_id" {
  description = "External ID for Datadog AWS integration"
  value       = var.datadog_external_id
}