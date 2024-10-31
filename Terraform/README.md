# AWS Server Setup with Terraform

## Overview

This repository contains Terraform configurations for setting up a tiered architecture on AWS. It follows best practices for scalability, security, and manageability, leveraging various AWS services to create a robust infrastructure.

## Architecture Diagram

![Architecture Diagram](https://github.com/sushant9822/aws-s3-assigment/blob/main/Terraform/s3-project.png)

## Directory Structure

The project is organized into directories representing different AWS services and components:
![Directory Structure](https://github.com/sushant9822/aws-s3-assigment/blob/main/screenshots/terraform-structure.png)
- `loadbalancer` - Application Load Balancer
- `ecr` - Amazon Elastic Container Registry
- `ecs` - Amazon Elastic Container Service (clusters and services)
- `vpc` - AWS Virtual Private Cloud
## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine
- An AWS account with appropriate permissions
- AWS CLI configured with your credentials
- An S3 bucket for storing Terraform state files (optional, if using remote state)

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/sushant9822/aws-s3-assigment.git
cd Terraform 
```
### Configuration
#### 1. Update Variables:
   
   Navigate to specific directory example: ECS, ALB, VPC etc
   Edit terraform.tfvars or use environment variables to set the required values for your setup.
   
#### 2. Initialize Terraform:
   ```bash
    terraform init
   ```
#### 3. Create Terraform workspace
   ```bash
   terraform workspace new <workspace name>
   ```
#### 4. Plan the Infrastructure:
   ```bash
   terraform plan
   ```
#### 5. Apply the Configuration:
   ```bash
   terraform apply
   ```
# Alternative Option with minmal resources
## Architecture Diagram EC2-ALB Setup

![Architecture Diagram](https://github.com/sushant9822/aws-s3-assigment/blob/main/Terraform/ec2-arch.png)

#### To use this option navigate to
```bash
cd EC2-ALB 
terraform init
terraform plan 
terraform apply --auto-approve
```
#### NOTE: IN this Option I have written user_data script while EC2 Creation will take care of installing and running app in background


   

