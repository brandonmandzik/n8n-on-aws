# Example Terraform variables file
# Copy this file to terraform.tfvars and customize for your deployment

# AWS Configuration
aws_region = "eu-central-1"

# EKS Cluster Configuration
cluster_name = "n8n"

# Node Configuration
node_instance_type = "t3.medium"
desired_capacity   = 2
min_capacity       = 1
max_capacity       = 4

# PostgreSQL Configuration
postgres_user          = "n8n_admin"
postgres_non_root_user = "n8n_user"
postgres_db            = "n8n"

# Note: PostgreSQL passwords are automatically generated as random 32-character strings
# They are stored in Terraform state and can be retrieved with:
# terraform output -json
