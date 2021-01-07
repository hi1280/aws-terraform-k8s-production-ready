locals {
  cluster_name    = "eks-example"
  cluster_version = "1.18"
}

provider "aws" {
  region = "ap-northeast-1"
}