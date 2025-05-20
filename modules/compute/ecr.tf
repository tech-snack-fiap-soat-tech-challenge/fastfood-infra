resource "aws_ecr_repository" "ecr" {
  for_each = local.ecr_repositories
  
  name = each.key
  image_scanning_configuration {
    scan_on_push = true
  }
}

output "ecr_urls" {
  value = {
    for repo_name, repo in aws_ecr_repository.ecr : repo_name => repo.repository_url
  }
}