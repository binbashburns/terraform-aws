# Terraform AWS Demo
## About
This is a sample AWS build using Terraform! 
The final product is a Virtual Private Cloud (VPC) with public and private subnets.
Although it took just over a day to build, it was built with security in mind. 
The S3 bucket has been encrypted, and no secrets are stored in plaintext or as variables. 
Secrets are managed in AWS Secrets Manager, which must be accessed from the AWS Management Console.

## Deliverables
Once this infrastructure is deployed, two values are provided so you can test it out:
1. IP Address to access a RedHat instance, which is deployed in the public subnet.
2. DNS address to access an Apache web server, which is deployed in the private subnet.

## Network Diagram
There is an accompanying Network Diagram in the main folder. Be sure to check it out. 
It definitely helps to visualize the different resources, and have a sense of their placement within the VPC.

## Resources:
- VPC (in US-East-1)
- Subnets (Two private, two public)
- Route Tables (One for private subnet, one public)
- NAT Gateway
- Internet Gateway
- Standalone EC2 Instance (Public)
- Auto Scaling Group (Spanning both Private Subnets)
- Application Load Balancer (Attached to Auto Scaling Group)
- Security Groups
- S3 Bucket
- KMS
- Secrets Manager

## References used:
https://aws.amazon.com/architecture/reference-architecture-diagrams/
https://courses.morethancertified.com/p/mtc-terraform
https://courses.morethancertified.com/p/devops-in-the-cloud
https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html
https://github.com/rhythmictech/terraform-aws-secretsmanager-keypair
https://lucid.app/lucidchart/
https://medium.com/cognitoiq/terraform-and-aws-application-load-balancers-62a6f8592bcf
https://registry.terraform.io/providers/hashicorp/aws/latest
https://stackoverflow.com/questions/54527189/define-terraform-aws-aws-instance-user-data
https://www.udemy.com/user/stephane-maarek/
https://youtube.com/