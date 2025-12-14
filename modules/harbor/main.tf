
resource "helm_release" "harbor" {
  name       = "harbor"
  repository = "https://helm.goharbor.io"
  chart      = "harbor"
  namespace  = "harbor"
  create_namespace = true

  values = [file("${path.module}/../../helm-values/harbor-values.yaml")]
}
