resource "aws_instance" "backend" {
  ami                  = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
  instance_type        = var.ec2_instance_type_backend
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  user_data = templatefile("scripts/backend_user_data.sh", {
    timestamp       = timestamp()
    datadog_api_key = var.datadog_api_key
    datadog_site    = var.datadog_site
  })
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  tags = {
    Name        = "${var.project_name}-backend"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

resource "aws_instance" "frontend" {
  ami                  = "ami-075d39ebbca89ed55" # Amazon Linux 2 AMI
  instance_type        = var.ec2_instance_type_frontend
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  user_data = templatefile("scripts/frontend_user_data.sh", {
    timestamp       = timestamp()
    datadog_api_key = var.datadog_api_key
    datadog_site    = var.datadog_site
  })
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]

  tags = {
    Name        = "${var.project_name}-frontend"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}
