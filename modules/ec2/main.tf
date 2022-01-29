# Provides Standalone RHEL instance, which is managed via SSH
resource "aws_instance" "rhel_ec2" {
  ami                         = var.ami
  subnet_id                   = var.sub2_id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [var.pub_ssh_sg]
  associate_public_ip_address = true
  key_name                    = var.key_name
  root_block_device {
    volume_size = 20
  }
  tags = {
    Name = "${var.base_name}_rhel_ec2"
  }
}

# Provides RHEL Launch Configuration, which will be used in the Auto Scaling Group
resource "aws_launch_configuration" "rhel_lc" {
  name            = "${var.base_name}_rhel_lc"
  image_id        = var.ami
  instance_type   = "t2.micro"
  security_groups = [var.pri_http_sg]
  root_block_device {
    volume_size = 20
  }
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    chkconfig httpd on
    systemctl enable httpd
    systemctl start httpd
    echo "<h1>Your website has been built successfully.</h1>" > /var/www/html/index.html
    EOF
  lifecycle {
    create_before_destroy = true
  }
}

# Provides Auto Scaling Group that uses the RHEL Launch Configuration as a template
resource "aws_autoscaling_group" "rhel_asg" {
  name                 = "${var.base_name}_rhel_asg"
  launch_configuration = aws_launch_configuration.rhel_lc.name
  min_size             = 2
  max_size             = 6
  desired_capacity     = 2
  health_check_type    = "EC2"
  vpc_zone_identifier  = [var.sub3_id, var.sub4_id]
  target_group_arns    = [var.alb_target_group_arn]
  lifecycle {
    create_before_destroy = true
  }
}

# Autoscaling Attachment. The communication channel of the ALB and ASG
resource "aws_autoscaling_attachment" "http_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.rhel_asg.name
  alb_target_group_arn   = var.alb_target_group_arn
}