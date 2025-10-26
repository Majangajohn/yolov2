variable "aws_region" {
  description = "AWS region for deployment"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Ubuntu 20.04 AMI ID"
  default     = "ami-0e86e20dae9224db8" # Ubuntu 20.04 in us-east-1
}

variable "aws_access_key" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}

variable "key_name" {
  description = "EC2 Key Pair Name"
  type        = string
  default     = "yolo-key"
}

variable "key_path" {
  description = "Path to private key file"
  type        = string
  default     = "~/.ssh/yolo-key.pem"
}