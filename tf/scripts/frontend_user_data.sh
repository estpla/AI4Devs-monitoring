#!/bin/bash
sudo yum update -y
sudo yum install -y docker

# Install Datadog Agent
DD_API_KEY=${datadog_api_key} DD_SITE=${datadog_site} bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Configure Datadog Agent
echo "hostname: $(hostname)-frontend" >> /etc/datadog-agent/datadog.yaml
echo "tags:" >> /etc/datadog-agent/datadog.yaml
echo "  - env:dev" >> /etc/datadog-agent/datadog.yaml
echo "  - service:frontend" >> /etc/datadog-agent/datadog.yaml
echo "  - project:lti-project" >> /etc/datadog-agent/datadog.yaml

# Start Datadog Agent
sudo systemctl restart datadog-agent
sudo systemctl enable datadog-agent

# Start Docker service
sudo service docker start

# Download and extract frontend code from S3
aws s3 cp s3://ai4devs-project-code-bucket-eph/frontend.zip /home/ec2-user/frontend.zip
unzip /home/ec2-user/frontend.zip -d /home/ec2-user/

# Build and run Docker container
cd /home/ec2-user/frontend
sudo docker build -t lti-frontend .
sudo docker run -d -p 3000:3000 lti-frontend

# Timestamp to force update
echo "Timestamp: ${timestamp}"
