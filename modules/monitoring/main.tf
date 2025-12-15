
resource "helm_release" "monitoring" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  create_namespace = true

  values = [file("${path.module}/../../helm-values/monitoring-values.yaml")]

  depends_on = [ module.eks ]
}
