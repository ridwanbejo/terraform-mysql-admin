resource "mysql_database" "databases" {
  for_each = { for idx, item in var.databases : item.name => item }

  name                  = each.value.name
  default_character_set = each.value.default_character_set
  default_collation     = each.value.default_collation
}

resource "random_password" "password" {
  for_each = { for idx, item in var.users : item.user => item }

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "mysql_user" "users" {
  for_each = { for idx, item in var.users : item.user => item }

  user               = each.value.user
  host               = each.value.host
  plaintext_password = random_password.password[each.value.user].result

  depends_on = [random_password.password]
}

resource "mysql_grant" "grants" {
  for_each = { for idx, item in local.users_with_grant : item.user => item }

  user       = each.value.user
  host       = each.value.host
  database   = each.value.grant.database
  privileges = each.value.grant.privileges

  depends_on = [mysql_user.users, mysql_database.databases]
}
