# Terraform backend configuration for state management
# Uncomment and configure this block to use S3 backend for team collaboration

# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"
#     key            = "n8n/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-state-locks"
#   }
# }

# To create the required S3 bucket and DynamoDB table, use:
# aws s3api create-bucket --bucket your-terraform-state-bucket --region us-east-1
# aws dynamodb create-table --table-name terraform-state-locks \
#   --attribute-definitions AttributeName=LockID,AttributeType=S \
#   --key-schema AttributeName=LockID,KeyType=HASH \
#   --billing-mode PAY_PER_REQUEST
