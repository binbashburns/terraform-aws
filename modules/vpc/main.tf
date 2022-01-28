# --- ./modules/vpc/main.tf --- 

# Provides VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.base_name}_vpc"
  }
}

### --- SUBNETS --- ###

# Provides Subnet 1 (PUBLIC)
resource "aws_subnet" "sub1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.sub1_cidr
  availability_zone = var.az1
  tags = {
    Name = "${var.base_name}_sub1_pub"
  }
}

# Provides Subnet 2 (PUBLIC)
resource "aws_subnet" "sub2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.sub2_cidr
  availability_zone = var.az2
  tags = {
    Name = "${var.base_name}_sub2_pub"
  }
}

# Provides Subnet 3 (PRIVATE)
resource "aws_subnet" "sub3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.sub3_cidr
  availability_zone = var.az1
  tags = {
    Name = "${var.base_name}_sub3_pri"
  }
}

# Provides Subnet 4 (PRIVATE)
resource "aws_subnet" "sub4" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.sub4_cidr
  availability_zone = var.az2
  tags = {
    Name = "${var.base_name}_sub4_pri"
  }
}

### --- INTERNET GATEWAY --- ###

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "internet_gateway"
  }
}

### --- SECURITY GROUPS --- ###

# Provides Security Group for SSH Access
resource "aws_security_group" "pub_ssh_sg" {
  name        = "ssh_access_public"
  description = "Allows SSH access from the public internet"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH port 22 from public internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description      = "SSH port 22 to public internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public_SSH_Access_SG"
  }
}

# Provides Security Group for Public HTTP Access
resource "aws_security_group" "pub_http_sg" {
  name        = "http_access_public"
  description = "Allows HTTP access from the public internet"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTP port 80 from public internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description      = "HTTP port 80 to public internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public_HTTP_Access_SG"
  }
}

# Provides Security Group for ALB-to-ASG HTTP Communication
resource "aws_security_group" "pri_http_sg" {
  name        = "http_access_private"
  description = "Allows HTTP access from the Application Load Balancer"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "HTTP port 80 from the Application Load Balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.pub_http_sg.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Private_HTTP_Access_SG"
  }
}

### --- APPLICATION LOAD BALANCER RESOURCES --- ###

# Provides the Application Load Balancer for HTTP traffic to the Auto Scaling Group
resource "aws_lb" "http_alb" {
  name               = "http-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.pub_http_sg.id]
  subnets = [
    aws_subnet.sub3.id,
    aws_subnet.sub4.id
  ]
}

# Points the Application Load Balancer to a Target Group (Auto Scaling Group)
resource "aws_lb_target_group" "http_tg" {
  name     = "http-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

# The ALB Listener. Allows the Application Load Balancer and Target Group to communicate
resource "aws_lb_listener" "http_alb_listener" {
  load_balancer_arn = aws_lb.http_alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http_tg.arn
  }
}