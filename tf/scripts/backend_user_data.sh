#!/bin/bash
yum update -y
sudo yum install -y docker

# Install Datadog Agent
DD_API_KEY=${datadog_api_key} DD_SITE=${datadog_site} bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Configure Datadog Agent
echo "hostname: $(hostname)-backend" >> /etc/datadog-agent/datadog.yaml
echo "tags:" >> /etc/datadog-agent/datadog.yaml
echo "  - env:dev" >> /etc/datadog-agent/datadog.yaml
echo "  - service:backend" >> /etc/datadog-agent/datadog.yaml
echo "  - project:lti-project" >> /etc/datadog-agent/datadog.yaml

# Start Datadog Agent
sudo systemctl restart datadog-agent
sudo systemctl enable datadog-agent

# Start Docker service
sudo service docker start

# Download and extract backend code from S3
aws s3 cp s3://ai4devs-project-code-bucket-eph/backend.zip /home/ec2-user/backend.zip
unzip /home/ec2-user/backend.zip -d /home/ec2-user/

# Build and run Docker container
cd /home/ec2-user/backend
sudo docker build -t lti-backend .
sudo docker run -d -p 8080:8080 lti-backend

# Timestamp to force update
echo "Timestamp: ${timestamp}"
