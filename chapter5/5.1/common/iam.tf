resource "aws_iam_policy" "container_build" {
  name   = "container-build"
  path   = "/service-role/"
  policy = file("./iam/container-build.json")
}

resource "aws_iam_role" "container_build" {
  name               = "container-build"
  path               = "/service-role/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "container_build" {
  role       = aws_iam_role.container_build.name
  policy_arn = aws_iam_policy.container_build.arn
}