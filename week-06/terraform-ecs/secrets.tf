resource "random_password" "db" {
  length  = 16
  special = false

}
resource "aws_secretsmanager_secret" "db" {
  name = "${var.prefix}-${var.app_name}-db-secret"
}
resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    DB_LINK = "postgresql://${var.db_username}:${random_password.db.result}@${aws_db_instance.main.address}:5432/${var.db_name}"
  })
}