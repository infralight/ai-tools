provider "aws" {
  region = var.region
}

module "flygpt" {
  source         = "../../src"
  memory_size    = 128
  timeout        = 30
  lambda_handler = "flygpt"
  project_name   = "flygpt"
  region         = var.region
}