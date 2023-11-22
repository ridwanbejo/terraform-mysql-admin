output "mysql_databases" {
  description = "Current MySQL databases"
  value       = module.tf_mysql_admin.mysql_databases
}

output "mysql_users" {
  description = "Current MySQL users"
  value       = module.tf_mysql_admin.mysql_users
}

output "mysql_grants" {
  description = "Current MySQL grant for users"
  value       = module.tf_mysql_admin.mysql_grants
}
