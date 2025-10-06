# Generate SSH private key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS Key Pair with public key
resource "aws_key_pair" "ec2_pem_key" {
  key_name   = var.key-name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "ec2_pem_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = var.key-name
}