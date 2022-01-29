# Terraform AWS Demo
## About
This is a sample AWS build using Terraform! </br>
The final product is a Virtual Private Cloud (VPC) with public and private subnets. </br>
Although it took just over a day to build, it was built with security in mind. </br>
The S3 bucket has been encrypted, and no secrets are stored in plaintext or as variables. </br>
Secrets are managed in AWS Secrets Manager, which must be accessed from the AWS Management Console.

## Deliverables
Once this infrastructure is deployed, two values are provided so you can test it out:</br>
1. IP Address to access a RedHat instance, which is deployed in the public subnet. Your SSH key is in Secrets Manager.
2. DNS address to access an Apache web server, which is deployed in the private subnet.
**NOTE**: the Apache Web Server will show a `502 Bad Gateway` message for about 15 minutes or so.</br>
Try waiting about 10 minutes, and refresh the page.

## Network Diagram
There is an accompanying Network Diagram in the main folder. Be sure to check it out. </br>
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
https://aws.amazon.com/architecture/reference-architecture-diagrams/ </br>
https://courses.morethancertified.com/p/mtc-terraform </br>
https://courses.morethancertified.com/p/devops-in-the-cloud </br>
https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html </br>
https://github.com/rhythmictech/terraform-aws-secretsmanager-keypair </br>
https://lucid.app/lucidchart/ </br>
https://medium.com/cognitoiq/terraform-and-aws-application-load-balancers-62a6f8592bcf </br>
https://registry.terraform.io/providers/hashicorp/aws/latest </br>
https://stackoverflow.com/questions/54527189/define-terraform-aws-aws-instance-user-data </br>
https://www.udemy.com/user/stephane-maarek/ </br>
https://youtube.com/ </br>