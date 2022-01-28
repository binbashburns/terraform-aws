## terraform-aws
This is a sample AWS build using Terraform!

# To do list:
- Add S3 Bucket
- Using the Random Provider, generate names of ASG Instances at runtime
- Add KMS-managed key to manage standalone EC2 instance
- Spread ASG instances across multiple availability zones
- Try to access the Apache Web Server with a browser

# Resources:
- 1 VPC
- 4 Subnets (Two private, two public)
- 1 Standalone EC2 Instance (Public)
- 1 Auto Scaling Group (Private)
- 1 Application Load Balancer (Attached to ASG)
- 2 Security Groups
- 1 S3 Bucket

# References used:
https://aws.amazon.com/architecture/reference-architecture-diagrams/
https://courses.morethancertified.com/p/mtc-terraform
https://courses.morethancertified.com/p/devops-in-the-cloud
https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html
https://lucid.app/lucidchart/
https://medium.com/cognitoiq/terraform-and-aws-application-load-balancers-62a6f8592bcf
https://registry.terraform.io/providers/hashicorp/aws/latest
https://stackoverflow.com/questions/54527189/define-terraform-aws-aws-instance-user-data
https://www.udemy.com/user/stephane-maarek/
https://youtube.com/
