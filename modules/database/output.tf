output "created_dbs" {
  value = [
    for db in aws_db_instance.postgres :
    {
      name     = db.name
      endpoint = db.endpoint
      port     = db.port
      engine   = db.engine
    }
  ]
}