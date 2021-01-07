locals {
  cluster_name    = "eks-example-staging"
  cluster_version = "1.18"
}

provider "aws" {
  region = "ap-northeast-1"
}