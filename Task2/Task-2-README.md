# Task 2 -- Application Deployment (Configuration Layer)

## Overview

This task demonstrates the deployment of a NodeJS Shopping Cart
application on AWS EC2 using a secure, production-grade architecture.\
The solution implements IAM Role-based authentication (no static
credentials), Application Load Balancer integration, and centralized
logging using Amazon CloudWatch.

------------------------------------------------------------------------

## Deployed Application URL

- http://nodejs-alb-906961827.ap-south-1.elb.amazonaws.com/buckets/

------------------------------------------------------------------------

## Architecture Design

The application is deployed within a custom VPC following a secure
multi-tier architecture.

### Infrastructure Components

-   Custom VPC
-   Public Subnets (Application Load Balancer)
-   Private Subnet (EC2 Application Server)
-   Internet Gateway
-   NAT Gateway
-   Security Groups
-   Application Load Balancer (ALB)
-   Target Group
-   EC2 Instance (NodeJS Application)

### Traffic Flow

Internet\
→ Application Load Balancer (Public Subnet)\
→ Target Group\
→ EC2 Instance (Private Subnet)\
→ NodeJS Application (Port 3000)

### Security Model

-   EC2 instance is deployed in a private subnet.
-   Direct internet access to EC2 is restricted.
-   ALB handles public traffic.
-   Security Groups enforce controlled inbound and outbound rules.
-   Health checks ensure high availability.

------------------------------------------------------------------------

## IAM Role Implementation

The EC2 instance uses an IAM Role (`jenkins-role`) attached via an
Instance Profile.

### Security Controls

-   No static AWS access keys are stored on the instance.
-   Temporary credentials are retrieved using AWS Instance Metadata
    Service (IMDSv2).
-   Credentials are automatically rotated via AWS STS.
-   Required permissions (CloudWatch Logs access) are granted using
    managed IAM policies.

### Benefits

-   Secure credential management
-   No hardcoded secrets
-   Automatic credential rotation
-   Compliance with AWS security best practices

------------------------------------------------------------------------

## Logging & Monitoring Strategy

Amazon CloudWatch Agent is installed on the EC2 instance to enable
centralized logging.

### Logging Architecture

NodeJS Application\
→ app.log\
→ CloudWatch Agent\
→ CloudWatch Log Group (`shopping-app-logs`)

### Implementation Details

-   Application logs are written to a local log file (`app.log`).
-   CloudWatch Agent collects logs using a custom configuration file.
-   Logs are pushed securely using IAM role permissions.
-   Centralized logs enable monitoring and troubleshooting.

### Advantages

-   Centralized visibility
-   Real-time monitoring
-   Secure log publishing
-   Production-ready observability approach

------------------------------------------------------------------------

## Conclusion

The NodeJS Shopping Cart application has been successfully deployed
using a secure and scalable AWS architecture.

The solution follows production-grade practices:

-   Private subnet deployment\
-   ALB-based traffic distribution\
-   IAM Role authentication\
-   Centralized logging with CloudWatch\
-   Secure and scalable infrastructure design

This implementation aligns with AWS best practices for security,
availability, and operational excellence.
