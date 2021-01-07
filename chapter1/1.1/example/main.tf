provider "aws" {
  region  = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0ce107ae7af2e92b5"
  instance_type = "t3.micro"
}
