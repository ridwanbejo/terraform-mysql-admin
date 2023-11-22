variable "mysql_databases" {
  type    = list(any)
  default = []
}

variable "mysql_users" {
  type    = list(any)
  default = []
}

variable "mysql_username" {
  type = string
}

variable "mysql_password" {
  type = string
}
