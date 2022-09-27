variable "region" {
  type    = string
  default = "us-east-2"
}

variable "db_username" {
  type    = string
  default = "root"
}

variable "db_password" {
  type    = string
  default = "admin"
}

variable "db_name" {
  type    = string
  default = "admin"
}

locals {
  app_env = {
    DB_HOST                = aws_db_instance.my_database.address
    DB_NAME                = var.db_name
    DB_USER                = var.db_username
    DB_PORT                = aws_db_instance.my_database.port
    DB_SSL_MODE            = "true"
    DB_PASSWORD            = var.db_password
    SITE_URL               = ""
    DJANGO_SETTINGS_MODULE = "settings.prod"
  }
}
