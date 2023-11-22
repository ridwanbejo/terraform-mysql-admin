<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_mysql"></a> [mysql](#requirement\_mysql) | 1.10.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mysql"></a> [mysql](#provider\_mysql) | 1.10.4 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [mysql_database.databases](https://registry.terraform.io/providers/bangau1/mysql/1.10.4/docs/resources/database) | resource |
| [mysql_grant.grants](https://registry.terraform.io/providers/bangau1/mysql/1.10.4/docs/resources/grant) | resource |
| [mysql_user.users](https://registry.terraform.io/providers/bangau1/mysql/1.10.4/docs/resources/user) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_databases"></a> [databases](#input\_databases) | n/a | <pre>list(object({<br>    name                  = string<br>    default_character_set = optional(string)<br>    default_collation     = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | n/a | <pre>list(object({<br>    user   = string<br>    host   = string<br>    grant  = optional(object({<br>      database    = string<br>      privileges = list(string)<br>    }))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mysql_databases"></a> [mysql\_databases](#output\_mysql\_databases) | List of MySQL databases |
| <a name="output_mysql_grants"></a> [mysql\_grants](#output\_mysql\_grants) | List of MySQL grant for users |
| <a name="output_mysql_users"></a> [mysql\_users](#output\_mysql\_users) | List of MySQL users |
<!-- END_TF_DOCS -->
