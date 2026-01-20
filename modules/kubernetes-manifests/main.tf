# Create gp3 StorageClass
resource "kubectl_manifest" "storageclass_gp3" {
  yaml_body = <<-YAML
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: gp3
    provisioner: ebs.csi.aws.com
    parameters:
      type: gp3
      encrypted: "true"
    volumeBindingMode: WaitForFirstConsumer
    allowVolumeExpansion: true
  YAML

  server_side_apply = true
}

# Deploy namespace
resource "kubectl_manifest" "namespace" {
  yaml_body = file("${path.module}/../../manifests/namespace.yaml")

  server_side_apply = true
}

# Deploy postgres-secret with templated values
resource "kubectl_manifest" "postgres_secret" {
  yaml_body = templatefile("${path.module}/../../manifests/postgres-secret.yaml", {
    postgres_user              = base64encode(var.postgres_user)
    postgres_password          = base64encode(var.postgres_password)
    postgres_db                = base64encode(var.postgres_db)
    postgres_non_root_user     = base64encode(var.postgres_non_root_user)
    postgres_non_root_password = base64encode(var.postgres_non_root_password)
  })

  server_side_apply = true

  depends_on = [kubectl_manifest.namespace]
}

# Deploy init-data ConfigMap for PostgreSQL
resource "kubectl_manifest" "init_data_configmap" {
  yaml_body = file("${path.module}/../../manifests/init-data-configmap.yaml")

  server_side_apply = true

  depends_on = [kubectl_manifest.namespace]
}

# Deploy PostgreSQL persistent volume claim
resource "kubectl_manifest" "postgres_pvc" {
  yaml_body = file("${path.module}/../../manifests/postgres-claim0-persistentvolumeclaim.yaml")

  server_side_apply = true
  wait              = false

  depends_on = [
    kubectl_manifest.namespace,
    kubectl_manifest.storageclass_gp3
  ]
}

# Deploy PostgreSQL deployment
resource "kubectl_manifest" "postgres_deployment" {
  yaml_body = file("${path.module}/../../manifests/postgres-deployment.yaml")

  server_side_apply = true

  depends_on = [
    kubectl_manifest.namespace,
    kubectl_manifest.postgres_secret,
    kubectl_manifest.postgres_pvc,
    kubectl_manifest.init_data_configmap
  ]
}

# Deploy PostgreSQL service
resource "kubectl_manifest" "postgres_service" {
  yaml_body = file("${path.module}/../../manifests/postgres-service.yaml")

  server_side_apply = true

  depends_on = [
    kubectl_manifest.namespace,
    kubectl_manifest.postgres_deployment
  ]
}

# Deploy n8n persistent volume claim
resource "kubectl_manifest" "n8n_pvc" {
  yaml_body = file("${path.module}/../../manifests/n8n-claim0-persistentvolumeclaim.yaml")

  server_side_apply = true
  wait              = false

  depends_on = [
    kubectl_manifest.namespace,
    kubectl_manifest.storageclass_gp3
  ]
}

# Deploy n8n deployment
resource "kubectl_manifest" "n8n_deployment" {
  yaml_body = file("${path.module}/../../manifests/n8n-deployment.yaml")

  server_side_apply = true

  depends_on = [
    kubectl_manifest.namespace,
    kubectl_manifest.postgres_service,
    kubectl_manifest.n8n_pvc
  ]
}

# Deploy n8n service (LoadBalancer)
resource "kubectl_manifest" "n8n_service" {
  yaml_body = file("${path.module}/../../manifests/n8n-service.yaml")

  server_side_apply = true

  depends_on = [
    kubectl_manifest.namespace,
    kubectl_manifest.n8n_deployment
  ]
}
