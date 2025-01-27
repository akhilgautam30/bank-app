# Bank Cloud Infrastructure Project

Overview
This README documents the setup, approach, and potential improvements application. The infrastructure supports a Frontend web app and two backend services, integrating with a third-party and databases

Architecture
![alt text](Architecture.png)

Infrastructure as Code
The entire infrastructure is defined using Terraform, The Terraform code is organized into reusable modules to avoid duplication and promote maintainability
Example - app service module
          private endpoint module

Security Considerations
Database is isolated in a private subnet and can be accessed by private endpoint
All sensitive information is stored in Azure Key Vault.
Network Security Groups (NSGs) are implemented to control traffic flow.
Azure WAF is used to protect the application

Scalability and High Availability
Azure app Service is used to deploy application code because of easy to deploy, auto scaling, high availability and always on features 
Azure Application Gateway is implemented for load balancing and SSL termination.
Azure API management for better control, monitoring, and documentation of APIs.


Setup

Prerequisites -
Azure subscription
Azure CLI
Terraform


Execution/ Deployment -

Deploymen can be performed through CICD pipeline or manually running commands-
Clone git repo
terraform init
terraform plan
terraform apply


What can be improved -

Enhanced Security Measures
Monitoring and Alerting
Containerization Strategy
IAM policy can be added