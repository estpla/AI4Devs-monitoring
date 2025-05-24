# Prompts

## Prompt 1

````md
# 📌 Terraform + Datadog AWS Integration Extension

**Objective:**  
Extend the existing Terraform codebase to fully integrate AWS with Datadog using **only Terraform**, and to provide complete observability for AWS resources.

---

## 🎯 Mission

Your mission is to update and expand the existing Terraform project with the following goals:

1. **Review the current Terraform configuration.**
2. **Configure the integration between AWS and Datadog using only Terraform.**
3. **Install the Datadog Agent on an EC2 instance.**
4. **Create a Datadog dashboard to monitor key AWS and EC2 metrics.**
5. **Add health monitors for the backend and frontend services.**

---

## 🛠️ Steps to Follow

### 1. Fully Configure AWS-Datadog Integration via Terraform
- Use Terraform resources to **completely define the integration** between AWS and Datadog, including:
  - IAM role delegation
  - AWS account setup in Datadog
  - External ID handling
- Do **not** perform any manual steps. The entire integration must be declared in code.
- Refer to the [Datadog AWS Integration Terraform Docs](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/integration_aws) for guidance.

### 2. Add Datadog Provider Configuration
- Add the Datadog provider block in Terraform.
- Use the **EU API endpoint**, setting the provider’s `api_url` to `https://api.datadoghq.eu/`.

### 3. Install Datadog Agent on EC2
- Modify the EC2 instance’s user data to:
  - Install the Datadog Agent
  - Configure it to use the EU Datadog site
  - Inject the API key via Terraform variables or secure means

### 4. Create a Dashboard in Datadog
- Use `datadog_dashboard` resource in Terraform.
- Include widgets for:
  - EC2 CPU, memory, disk, network
  - AWS services like RDS, ELB
  - Backend and frontend availability/latency

### 5. Define Health Monitors
- Use `datadog_monitor` to define:
  - A monitor for backend service availability (e.g., HTTP 5xx rate, high latency)
  - A monitor for frontend service health (e.g., ping, load time, 4xx errors)
- Configure alert conditions, thresholds, and notification messages.
- Attach monitors to the dashboard if relevant.

### 6. Define All Required Variables
Create or update the file `tf/variables.tf` to include the following, each with a meaningful `description`:

| Variable Name         | Description                                                        |
|-----------------------|--------------------------------------------------------------------|
| `aws_region`          | AWS region where resources will be deployed                        |
| `aws_access_key`      | AWS Access Key for programmatic access                             |
| `aws_secret_key`      | AWS Secret Key for programmatic access                             |
| `datadog_api_key`     | Datadog API key for agent and Terraform authentication             |
| `datadog_app_key`     | Datadog Application key for API access beyond metrics ingestion     |
| `datadog_api_url`     | Datadog API base URL; must be `https://api.datadoghq.eu/` for EU    |
| `ec2_instance_type`   | The instance type for the EC2 (e.g., `t3.micro`)                   |

---

## ✅ Deliverables

- Updated and new Terraform code implementing the above functionality
- A root-level `README.md` file including:
  - Explanation of all changes made
  - Screenshots of the Datadog dashboard and any alerts/monitors
  - A `datadog-aws-prompts.md` file documenting prompts used for Datadog integrations or dashboards
  - A section describing any challenges and how they were resolved

---

## 📎 Additional Requirements

- Ensure Terraform code passes formatting and validation:  
  `terraform fmt && terraform validate`
- Follow best practices:
  - Use modules where appropriate
  - Keep code DRY and parameterized
- Store all variable declarations in `tf/variables.tf` with a description
- **Do not perform any manual configuration in the Datadog UI**
- **All configuration must target the EU Datadog API (`https://api.datadoghq.eu/`)**
- Credentials (AWS and Datadog) must be managed securely using environment variables or secret managers

---

> ℹ️ This is an infrastructure-as-code-only project. No manual setup is allowed. Everything must be reproducible via `terraform apply`.
````