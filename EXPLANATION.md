# YOLO E-commerce Application Deployment Explanation

This document details the setup and execution of the YOLO e-commerce application for Stage 1 (Vagrant) and Stage 2 (AWS).

## Stage 1: Vagrant Deployment

### Vagrantfile Creation
1. Initialized with:
```bash
    vagrant init geerlingguy/ubuntu2004
```



#### Step 2: Set Up AWS Credentials as Environment Variables
**Obtain AWS Credentials:**
Log in to the AWS Management Console.
Navigate to **IAM > Users > [Your User] > Security credentials**.
Create an access key under Access keys and download the CSV containing ```Access Key ID``` and ```Secret Access Key```.


**Set Environment Variables:**
- On your host machine (Linux/Mac), set the environment variables:
and make them persistent, add to ```~/.bashrc ``` or ```~/.zshrc```:

```bash
echo "export AWS_ACCESS_KEY_ID=your-access-key-id" >> ~/.bashrc
echo "export AWS_SECRET_ACCESS_KEY=your-secret-access-key" >> ~/.bashrc
source ~/.bashrc
```
- Verify:
```bash
echo $AWS_ACCESS_KEY_ID
echo $AWS_SECRET_ACCESS_KEY
```

**Configure Terraform to Use Environment Variables:**
Terraform automatically reads ```AWS_ACCESS_KEY_ID ```and ```AWS_SECRET_ACCESS_KEY``` for the AWS provider, so no explicit variables are needed for credentials in ```variables.tf```.

```bash
export TF_VAR_aws_access_key=$AWS_ACCESS_KEY_ID
export TF_VAR_aws_secret_key=$AWS_SECRET_ACCESS_KEY
export TF_VAR_aws_region=$AWS_DEFAULT_REGION

```