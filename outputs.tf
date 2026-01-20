output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_region" {
  description = "AWS region where the cluster is deployed"
  value       = var.aws_region
}

output "configure_kubectl" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}

output "get_loadbalancer_url" {
  description = "Command to get n8n LoadBalancer URL"
  value       = "kubectl get svc n8n -n n8n -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
}

output "postgres_credentials_info" {
  description = "Information about PostgreSQL credentials"
  value       = "PostgreSQL passwords are randomly generated. Use 'terraform output -json' to retrieve them if needed (stored in state)."
}
