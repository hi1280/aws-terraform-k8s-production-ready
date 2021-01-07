provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}

resource "helm_release" "cluster_autoscaler" {
  name       = "autoscaler"
  namespace  = "kube-system"

  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "awsRegion"
    value = "ap-northeast-1"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = "eks-example"
  }

  set {
    name  = "image.tag"
    value = "v1.17.4"
  }
}