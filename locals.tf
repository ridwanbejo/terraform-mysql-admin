locals {
  users_with_grant = [
    for item in var.users :
    item
    if item.grant.database != ""
  ]
}
