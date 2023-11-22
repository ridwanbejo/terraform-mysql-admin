output "mysql_databases" {
  description = "List of MySQL databases"
  value       = { for item in mysql_database.databases : item.name => item.default_character_set }
}

output "mysql_users" {
  description = "List of MySQL users"
  value       = { for item in mysql_user.users : item.user => item.host }
}

output "mysql_grants" {
  description = "List of MySQL grant for users"
  value       = { for item in mysql_grant.grants : item.user => item.privileges }
}
