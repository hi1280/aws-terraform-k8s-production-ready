data "aws_caller_identity" "current" {}

resource "aws_iam_role" "eks_admin_role" {
  name = "eks-admin-role"

  assume_role_policy = <<EOS
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Effect": "Allow"
    }
  ]
}
EOS
}

resource "aws_iam_role" "eks_develop_role" {
  name = "eks-develop-role"

  assume_role_policy = <<EOS
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Effect": "Allow"
    }
  ]
}
EOS
}

resource "aws_iam_group" "eks_admin_group" {
  name = "admin"
}

resource "aws_iam_group" "eks_develop_group" {
  name = "develop"
}

resource "aws_iam_group_policy" "eks_admin_policy" {
  name  = "eks_admin_policy"
  group = aws_iam_group.eks_admin_group.name

  policy = templatefile("./iam/eks-admin-policy.json", {
    account_id = data.aws_caller_identity.current.account_id
  })
}

resource "aws_iam_group_policy" "eks_develop_policy" {
  name  = "eks_develop_policy"
  group = aws_iam_group.eks_develop_group.name

  policy = templatefile("./iam/eks-develop-policy.json", {
    account_id = data.aws_caller_identity.current.account_id
  })
}

resource "aws_iam_user" "admin_user" {
  name = "admin_user"
}

resource "aws_iam_user" "develop_user" {
  name = "develop_user"
}

resource "aws_iam_user_group_membership" "admin" {
  user = aws_iam_user.admin_user.name

  groups = [
    aws_iam_group.eks_admin_group.name,
  ]
}

resource "aws_iam_user_group_membership" "develop" {
  user = aws_iam_user.develop_user.name

  groups = [
    aws_iam_group.eks_develop_group.name,
  ]
}
