output "namespace" {
  description = "Kubernetes namespace where n8n is deployed"
  value       = "n8n"
}

output "deployment_info" {
  description = "Information about the deployed resources"
  value = {
    postgres_deployment = "postgres"
    postgres_service    = "postgres"
    n8n_deployment      = "n8n"
    n8n_service         = "n8n"
  }
}
