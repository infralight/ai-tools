resource "aws_ecr_repository" "self" {
  name = var.project_name
  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = false
  }
  image_tag_mutability = "MUTABLE"
}

data "aws_ecr_image" "service_image" {
  repository_name = split("/", aws_ecr_repository.self.repository_url)[1]
  image_tag       = "latest"
}