module "eks" {
  source = "./modules/eks"

  cluster_name       = var.cluster_name
  aws_region         = var.aws_region
  node_instance_type = var.node_instance_type
  desired_capacity   = var.desired_capacity
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
}

module "n8n" {
  source = "./modules/kubernetes-manifests"

  depends_on = [module.eks]

  postgres_user              = var.postgres_user
  postgres_password          = random_password.postgres_password.result
  postgres_non_root_user     = var.postgres_non_root_user
  postgres_non_root_password = random_password.postgres_non_root_password.result
  postgres_db                = var.postgres_db
}

resource "random_password" "postgres_password" {
  length  = 32
  special = true
}

resource "random_password" "postgres_non_root_password" {
  length  = 32
  special = true
}
