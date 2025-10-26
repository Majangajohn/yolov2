provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  # Credentials read from AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables
}

resource "aws_security_group" "yolo_sg" {
  name        = "yolo_sg"
  description = "Allow traffic for YOLO app"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "yolo_sg"
  }
}

resource "aws_instance" "yolo_server" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.yolo_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "yolo-server"
  }

  # Wait for instance to be ready
  provisioner "local-exec" {
    command = "sleep 60" # Wait 60 seconds for instance initialization
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${self.public_ip}, playbook.yml --user ubuntu --private-key ${var.key_path} --ssh-common-args='-o StrictHostKeyChecking=no'"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.key_path)
    host        = self.public_ip
    timeout     = "5m"
  }
}