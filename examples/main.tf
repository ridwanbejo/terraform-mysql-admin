module "tf_mysql_admin" {
  source    = "../"
  databases = local.databases
  users     = local.users
}
