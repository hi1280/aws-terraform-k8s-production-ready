module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "14.0.0"
  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version
  subnets         = module.vpc.public_subnets

  vpc_id = module.vpc.vpc_id

  node_groups = {
    ng-1 = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 2
      instance_types   = ["t3.small"]
    }
  }

  write_kubeconfig = false
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
