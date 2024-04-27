terraform {
  backend "s3" {
    bucket         = "test"
    region         = "us-east-1"
    key            = "terraform.tfstate"
    dynamodb_table = "dev"
    assume_role_with_web_identity = {
      role_arn                = "arn:0000"
      web_identity_token_file = "/tmp/aws-oidc-token"
    }
  }
}
