terraform {
  backend "s3" {
    bucket         = "test"
    region         = "us-east-1"
    key            = "terraform.tfstate"
    dynamodb_table = "test"
    assume_role_with_web_identity = {
      role_arn   = "arn:00000"
      token_file = "/tmp/aws-oidc-token"
    }
  }
}
