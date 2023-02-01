data "aws_secretsmanager_secret" "mongo_password_secret" {
  name = "MongoPassword2"
}