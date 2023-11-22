terraform {
  required_version = ">= 1.4"

  required_providers {
    mysql = {
      source  = "bangau1/mysql"
      version = "1.10.4"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}
