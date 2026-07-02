
# Terraform AWS EC2 Lab Setup

> **Hands-on Lab: Provision an Amazon EC2 Instance using Terraform on AWS**

---

# Lab Objective

In this lab, you will learn how to:

* Install Terraform
* Install AWS CLI
* Configure AWS Credentials
* Create an IAM User
* Write Terraform configuration files
* Provision an Amazon EC2 Instance
* Verify the infrastructure
* Connect to the EC2 Instance
* Destroy the infrastructure

---

# Lab Architecture

> **Insert your Terraform Architecture Diagram here**

```text
Your Machine (WSL / Oracle Linux 8)

AWS CLI Installed

Terraform Installed

        │

terraform plan

terraform apply

        ▼

AWS Provider

        ▼

AWS API

        ▼

AWS Cloud

        ▼

EC2 Instance
```

---

# Lab Workflow

> **Insert your Terraform Workflow Diagram here**

```text
Create Project Folder

↓

Write Terraform Files

↓

terraform init

↓

terraform validate

↓

terraform fmt

↓

terraform plan

↓

terraform apply

↓

AWS API

↓

EC2 Created

↓

terraform output

↓

SSH into EC2

↓

terraform destroy
```

---

# Lab Prerequisites

Before starting this lab, ensure you have:

* AWS Account
* IAM User with EC2 permissions
* AWS Access Key
* AWS Secret Access Key
* AWS CLI Installed
* Terraform Installed
* Git Installed
* VS Code
* WSL (Ubuntu) or Oracle Linux 8

---

# Step 1 – Install AWS CLI

Verify the installation.

```bash
aws --version
```

Expected Output

```text
aws-cli/2.x.x
```

---

# Step 2 – Install Terraform

Verify the installation.

```bash
terraform version
```

Expected Output

```text
Terraform v1.x.x
```

---

# Step 3 – Configure AWS CLI

Configure your AWS credentials.

```bash
aws configure
```

Enter:

```text
AWS Access Key ID

AWS Secret Access Key

Default Region

Output Format
```

Example

```text
Region : ap-south-1

Output : json
```

Verify the configuration.

```bash
aws sts get-caller-identity
```

If successful, AWS returns your account information.

---

# Step 4 – Create the Project Directory

```bash
mkdir terraform-ec2-lab

cd terraform-ec2-lab
```

Verify

```bash
pwd
```

---

# Step 5 – Create Terraform Files

Create the following files.

```bash
touch provider.tf
touch main.tf
touch variables.tf
touch terraform.tfvars
touch outputs.tf
```

Project Structure

```text
terraform-ec2-lab/

├── provider.tf
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
└── README.md
```

---

# Step 6 – Configure the AWS Provider

Create **provider.tf**

```hcl
terraform {

  required_providers {

    aws = {

      source  = "hashicorp/aws"
      version = "~> 5.0"

    }

  }

}

provider "aws" {

  region = var.region

}
```

---

# Step 7 – Create Variables

Create **variables.tf**

```hcl
variable "region" {

  default = "ap-south-1"

}

variable "ami" {}

variable "instance_type" {}

variable "key_name" {}
```

---

# Step 8 – Assign Variable Values

Create **terraform.tfvars**

```hcl
region = "ap-south-1"

ami = "ami-xxxxxxxx"

instance_type = "t3.micro"

key_name = "my-keypair"
```

> Replace the AMI ID and Key Pair with values from your AWS account.

---

# Step 9 – Create the EC2 Resource

Create **main.tf**

```hcl
resource "aws_instance" "web" {

  ami           = var.ami

  instance_type = var.instance_type

  key_name      = var.key_name

  tags = {

    Name = "Terraform-EC2"

  }

}
```

---

# Step 10 – Create Outputs

Create **outputs.tf**

```hcl
output "public_ip" {

  value = aws_instance.web.public_ip

}

output "private_ip" {

  value = aws_instance.web.private_ip

}
```

---

# Step 11 – Initialize Terraform

Run:

```bash
terraform init
```

Purpose

* Downloads the AWS Provider
* Creates the `.terraform` directory
* Initializes the working directory

---

# Step 12 – Validate the Configuration

```bash
terraform validate
```

Purpose

Checks the syntax of all Terraform files.

---

# Step 13 – Format the Code

```bash
terraform fmt
```

Purpose

Formats the Terraform configuration files.

---

# Step 14 – Review the Execution Plan

```bash
terraform plan
```

Purpose

Displays the changes Terraform will make without creating resources.

Review the output carefully before proceeding.

---

# Step 15 – Create the EC2 Instance

```bash
terraform apply
```

When prompted, type:

```text
yes
```

Terraform provisions the EC2 instance in AWS.

---

# Step 16 – Verify the EC2 Instance

### AWS Console

Navigate to:

```text
EC2

↓

Instances
```

Verify that the EC2 instance has been created.

---

### Using AWS CLI

```bash
aws ec2 describe-instances
```

---

# Step 17 – View Terraform Outputs

```bash
terraform output
```

Example Output

```text
public_ip = 13.xxx.xxx.xxx

private_ip = 172.xxx.xxx.xxx
```

---

# Step 18 – Connect to the EC2 Instance

```bash
ssh -i my-keypair.pem ec2-user@<PUBLIC_IP>
```

Example

```bash
ssh -i my-keypair.pem ec2-user@13.234.xx.xx
```

---

# Step 19 – View Terraform State

```bash
terraform show
```

List managed resources.

```bash
terraform state list
```

Expected Output

```text
aws_instance.web
```

---

# Step 20 – Destroy the Infrastructure

To avoid unnecessary AWS charges:

```bash
terraform destroy
```

Type:

```text
yes
```

Terraform deletes the EC2 instance and removes it from the state.

---

# Frequently Used Terraform Commands

```bash
terraform init

terraform validate

terraform fmt

terraform plan

terraform apply

terraform output

terraform show

terraform state list

terraform destroy
```

---

# Lab Summary

In this lab, you successfully:

* Installed Terraform
* Configured AWS CLI
* Authenticated with AWS
* Created Terraform configuration files
* Provisioned an EC2 instance
* Verified the deployment
* Retrieved resource outputs
* Connected to the EC2 instance using SSH
* Destroyed the infrastructure using Terraform

---

# Cleanup

To prevent AWS charges:

* Run `terraform destroy`
* Confirm the EC2 instance is terminated
* Verify no unused Elastic IPs or EBS volumes remain

---
