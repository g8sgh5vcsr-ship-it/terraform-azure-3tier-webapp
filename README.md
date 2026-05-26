# Terraform Azure 3-Tier Web App

A 3-tier web application deployed on Microsoft Azure using Terraform.

![Architecture](docs/architecture.png)


## What It Builds

- Virtual Network with subnets for each tier
- App Service (the web app)
- Azure SQL Database (data layer)
- Key Vault (stores SQL password securely)
- Application Gateway (public front door)

The App Service uses Managed Identity to fetch secrets from Key Vault — no passwords in code.


## Tech Stack

Terraform (HCL) · Azure · Azure CLI · Git

## structure
├── main.tf, variables.tf, outputs.tf   (top-level)
├── docs/                                (diagram + screenshots)
└── modules/
├── network/
├── compute/
├── data/
└── appgw/


## Deploy
terraform init
terraform plan
terraform apply

To clean
terraform destroy

## Cost

About $5/month if you destroy after each session. Around $200/month if left running 24/7.

## What I Learned

- Writing modular Terraform code (HCL)
- Connecting modules through inputs and outputs
- Using Managed Identity to access Key Vault securely
- Managing Terraform state and recovering with `terraform import`
- Cost discipline by destroying resources after each session


