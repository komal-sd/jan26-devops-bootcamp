# ─────────────────────────────────────────
# outputs.tf
# Useful values shown after apply
# ─────────────────────────────────────────

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.app.repository_url
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.cluster.name
}

output "db_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.main.address
}

output "secret_arn" {
  description = "Secret Manager ARN"
  value       = aws_secretsmanager_secret.db.arn
}