#### RDS ####

#### RDS ####
resource "aws_db_subnet_group" "am-db-sub-grp" {
  name       = "am-db-sub-grp"
  subnet_ids = values(aws_subnet.AM-DB-subnet)[*].id
}

resource "aws_db_instance" "AM-db" {
  allocated_storage           = 100
  storage_type                = "gp3"
  engine                      = "mysql"
  engine_version              = "8.0"
  instance_class              = "db.t2.micro"
  identifier                  = "am-db"
  username                    = var.db_username
  password                    = var.db_password
  parameter_group_name        = "default.mysql8.0"
  db_subnet_group_name        = aws_db_subnet_group.am-db-sub-grp.name
  multi_az                    = true
  skip_final_snapshot         = true
  publicly_accessible          = false

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}