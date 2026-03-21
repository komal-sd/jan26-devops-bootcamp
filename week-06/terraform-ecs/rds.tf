resource "aws_db_subnet_group" "default" {
  name       = "${var.prefix}-db-subnet-group"
  subnet_ids = [aws_subnet.private_rds_1.id, aws_subnet.private_rds_2.id]
}

resource "aws_db_instance" "main" {
  identifier        = "${var.prefix}-${var.db_name}-db"
  allocated_storage = 20
  engine            = "postgres"
  engine_version    = "15.14"
  instance_class    = "db.t3.micro"

  db_name  = var.db_name
  username = var.db_username
  password = "placeholder123"

  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true
  publicly_accessible = false
}