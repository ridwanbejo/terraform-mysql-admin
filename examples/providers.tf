terraform {
  required_version = ">= 1.4"

  required_providers {
    mysql = {
      source  = "bangau1/mysql"
      version = "1.10.4"
    }
  }
}

provider "mysql" {
  endpoint = "localhost:3306"
  username = local.username
  password = local.password
}
