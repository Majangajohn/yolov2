variable "aws_region" {
  default = "us-east-1"
}

variable "aws_access_key" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
  default = "AWS_ACCESS_KEY_ID"
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
  default = "AWS_SECRET_ACCESS_KEY"
}

variable "ami_id" {
  description = "Ubuntu 20.04 AMI ID"
  default     = "ami-0e86e20dae9224db8" 
}

variable "key_name" {
  description = "EC2 Key Pair Name"
  type        = string
  default     = "yolo-key"
}

variable "key_path" {
  description = "Path to your SSH private key"
  type        = string
  default     = "~/.ssh/yolo-key.pem"
}