resource "aws_ecr_repository" "ecr" {
  name = "fiap-fastfood"
  image_scanning_configuration {
    scan_on_push = true
  }
}

output "ecr_url" {
  value = aws_ecr_repository.ecr.repository_url
}