# Generates a secure private key and encodes it as PEM
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Provides an EC2 key pair resource
resource "aws_key_pair" "keypair" {
  key_name_prefix = var.base_name
  public_key      = tls_private_key.key.public_key_openssh
}

# Provides a resource to manage AWS Secrets Manager secret metadata
resource "aws_secretsmanager_secret" "secret_key" {
  name_prefix = var.base_name
  description = var.description
  tags = {
    Name = "${var.base_name}-key"
  }
}

# Provides a resource to manage AWS Secrets Manager secret version including its secret value
resource "aws_secretsmanager_secret_version" "secret_key_value" {
  secret_id     = aws_secretsmanager_secret.secret_key.id
  secret_string = tls_private_key.key.private_key_pem
}