# AWS DevOps Test -- Infrastructure as Code (Task 1)
   

  Provision a production-ready AWS infrastructure using Terraform. The infrastructure is designed with high availability, security isolation, modularity, and cost optimization in mind.

Region: ap-south-1

##  Architecture Diagram (ASCII)



                              Internet
                                  │
                          Internet Gateway
                                  │
        ┌───────────────────────────────────────────────┐
        │                    VPC                        │
        │                 10.0.0.0/16                   │
        │                                               │
        │   ┌──────────────────────────────┐            │
        │   │        Public Subnet A       │            │
        │   │        (ap-south-1a)         │            │
        │   │                              │            │
        │   │  • Jenkins Master (EC2)      │            │
        │   │  • NAT Gateway               │            │
        │   └───────────────┬──────────────┘            │
        │                   │                           │
        │   ┌───────────────▼──────────────┐            │
        │   │        Public Subnet B       │            │
        │   │        (ap-south-1b)         │            │
        │   │  • Reserved for ALB (HA)     │            │
        │   └──────────────────────────────┘            │
        │                                               │
        │   ┌──────────────────────────────┐            │
        │   │        Private Subnet A      │            │
        │   │                              │            │
        │   │  • Jenkins Agent             │            │
        │   │  • Application EC2           │            │
        │   └──────────────────────────────┘            │
        │                                               │
        │   ┌──────────────────────────────┐            │
        │   │        Private Subnet B      │            │
        │   │        (Reserved for HA)     │            │
        │   └──────────────────────────────┘            │
        └───────────────────────────────────────────────┘


Supporting Services (Outside VPC)

 • IAM Roles (Least Privilege)
 • S3 Bucket (Artifacts / Terraform State)
 • CloudWatch Logs

## Resources Created

### Networking

-  Custom VPC (10.0.0.0/16)
-  2 Public Subnets (Multi-AZ)
-  2 Private Subnets (Multi-AZ)
-  Internet Gateway
-  NAT Gateway 
-  Separate Route Tables for public/private

### Security

-   Jenkins Security Group
-   Application Security Group
-   IAM Roles attached to EC2 (no access keys)

### IAM

-   EC2 IAM Role
-   IAM Policy (S3 Access)
-   Instance Profile

### Compute

-   Jenkins Master (Public Subnet)
-   Jenkins Agent (Private Subnet)
-   App-Server (Private Subnet)
    
    -   Instance Type: t2.micro

### Storage

-   S3 Bucket for Build Artifacts
-   Public access blocked
-   IAM-based access control
------------------------------------------------------------------------

## Variables and Defaults

| Variable | Description         | Value Used            |
| -------- | ------------------- | --------------------- |
| region   | AWS Region          | ap-south-1            |
| vpc_cidr | VPC CIDR Block      | 10.0.0.0/16           |
| ami_id   | EC2 AMI ID (Ubuntu) | ami-019715e0d74f695be |
| key_name | EC2 SSH Key Pair    | neha-1                |


------------------------------------------------------------------------

##  How To Initialize

 terraform init

(This downloads required providers and initializes the working directory.)


------------------------------------------------------------------------
## How To Deploy
    
- Validate Configuration
  terraform validate

 (Ensures syntax correctness.)

- Review Execution Plan
  terraform plan

  (Shows resources that will be created.)

- Deploy Infrastructure
  terraform apply

## How To Destroy
   
   terraform destroy


## Conclusion
-   IAM Roles are used instead of access keys.
-   Jenkins runs in Public Subnet.
-   Jenkins Agent & Application run in Private Subnet.
-   NAT Gateway provides outbound internet access for private instances.

