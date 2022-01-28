# --- ./modules/ec2/outputs.tf --- 
output "ec2_ssh_pub_ip" {
    value = aws_instance.rhel_ec2.public_ip
}