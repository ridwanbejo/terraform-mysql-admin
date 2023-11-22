# Terraform MySQL Admin

This is a Terraform module for managing databases and user access at MySQL. You can use this module both for commercial or non-commercial purposes.

Currently, you can manage these resources in MySQL by using this module:

- databases
- users
- roles

Tested in:

- MySQL

## A. Prerequisites

Requirements:

- Terraform with version >= 1.4
- bangau1/mysql
- Hashicorp/random

## B. How to use this module for your Terraform project ?

- Copy `example` project from this module. You can extend it as per your requirements
- Configure MySQL hostname by modifying the `providers.tf`. For example `localhost:3306`
  - If you want to use another authentication method, [please read more at the provider documentation](https://registry.terraform.io/providers/bangau1/mysql/latest/docs)
- Configure `TF_VAR_mysql_user` and `TF_VAR_mysql_password` as environment variables. For example:

```
$ export TF_VAR_mysql_username=root
$ export TF_VAR_mysql_password=example
```

- Create `terraform.tfvars` inside the Project. Then copy this sample terraform.tfvars into the file:

```
mysql_databases = [
  {
    name                  = "toko_mobil"
    default_character_set = "utf8"
    default_collation     = "utf8_general_ci"
  },
  {
    name = "toko_baju"
  },
  {
    name = "toko_cat"
  },
  {
    name = "toko_jam_tangan"
  },
]

mysql_users = [
  {
    user = "puguh"
    host = "localhost"
    grant = {
      database = "toko_jam_tangan",
      privileges = ["SELECT", "UPDATE"]
    }
  },
  {
    user = "panji"
    host = "localhost"
    grant = {
      database = "toko_baju",
      privileges = ["SELECT", "UPDATE", "DELETE"]
    }
  },
  {
    user = "alam"
    host = "localhost"
    grant = {
      database = "toko_mobil",
      privileges = ["SELECT", "UPDATE", "DELETE", "DROP"]
    }
  },
  {
    user = "jeffry"
    host = "localhost"
    grant = {
      database = ""
      privileges = []
    }
  },
]
```

- Adjust the tfvars based on your requirements. The tfvars above is just example. Then, Save it
- Run these commands:

```
$ terraform init
$ terraform plan
```
This is the output when you run terraform plan successfully:

```
...

Plan: 15 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + mysql_databases = {
      + toko_baju       = "utf8"
      + toko_cat        = "utf8"
      + toko_jam_tangan = "utf8"
      + toko_mobil      = "utf8"
    }
  + mysql_grants    = {
      + alam  = [
          + "DELETE",
          + "DROP",
          + "SELECT",
          + "UPDATE",
        ]
      + panji = [
          + "DELETE",
          + "SELECT",
          + "UPDATE",
        ]
      + puguh = [
          + "SELECT",
          + "UPDATE",
        ]
    }
  + mysql_users     = {
      + alam   = "localhost"
      + jeffry = "localhost"
      + panji  = "localhost"
      + puguh  = "localhost"
    }

```

After you feel confidence with the terraform plan output, let's apply it.

```
$ terraform apply -auto-approve
```

- If it succeed, you must see this kind of output on your terminal

```
...

module.tf_mysql_admin.mysql_grant.grants["puguh"]: Creating...
module.tf_mysql_admin.mysql_grant.grants["alam"]: Creating...
module.tf_mysql_admin.mysql_grant.grants["panji"]: Creating...
module.tf_mysql_admin.mysql_grant.grants["puguh"]: Creation complete after 3s [id=puguh@localhost:`toko_jam_tangan`]
module.tf_mysql_admin.mysql_grant.grants["panji"]: Creation complete after 3s [id=panji@localhost:`toko_baju`]
module.tf_mysql_admin.mysql_grant.grants["alam"]: Creation complete after 3s [id=alam@localhost:`toko_mobil`]

Apply complete! Resources: 15 added, 0 changed, 0 destroyed.

Outputs:

mysql_databases = {
  "toko_baju" = "utf8"
  "toko_cat" = "utf8"
  "toko_jam_tangan" = "utf8"
  "toko_mobil" = "utf8"
}
mysql_grants = {
  "alam" = toset([
    "DELETE",
    "DROP",
    "SELECT",
    "UPDATE",
  ])
  "panji" = toset([
    "DELETE",
    "SELECT",
    "UPDATE",
  ])
  "puguh" = toset([
    "SELECT",
    "UPDATE",
  ])
}
mysql_users = {
  "alam" = "localhost"
  "jeffry" = "localhost"
  "panji" = "localhost"
  "puguh" = "localhost"
}
```

You will see at your MySQL that users and databases are created once the terraform applied.

## C. Understanding tfvars scenarios

There are some scenarios that you could choose by using this module. For example:

1. You might want to create the database with default collation and charset:

```
mysql_databases = [
  {
    name = "toko_jam_tangan"
  },
]
```

2. You can also create database by with different collation and charset:

```
mysql_databases = [
  {
    name                  = "toko_mobil"
    default_character_set = "utf8"
    default_collation     = "utf8_general_ci"
  },
  {
    name = "toko_baju"
  },
  {
    name = "toko_cat"
  },
  {
    name = "toko_jam_tangan"
  },
]
```

3. You can create user without grant

```
mysql_users = [
  {
    user = "jeffry"
    host = "localhost"
    grant = {
      database = ""
      privileges = []
    }
  },
]
```

4. You can create users with grant option also

```
mysql_users = [
  {
    user = "puguh"
    host = "localhost"
    grant = {
      database = "toko_jam_tangan",
      privileges = ["SELECT", "UPDATE"]
    }
  },
  {
    user = "panji"
    host = "localhost"
    grant = {
      database = "toko_baju",
      privileges = ["SELECT", "UPDATE", "DELETE"]
    }
  },
  {
    user = "alam"
    host = "localhost"
    grant = {
      database = "toko_mobil",
      privileges = ["SELECT", "UPDATE", "DELETE", "DROP"]
    }
  },
]
```

## D. Ensuring quality

I am trying to follow these approaches for ensuring quality of the tf-module:

- **validate**, ensure my Terraform module is in correct configuration based on Terraform guideline
- **auto-format**, ensure my Terraform script is edited with correct format based on Terraform guideline
- **linter**, ensure my Terraform script is in correct format based on Terraform guideline
- **security**, ensure my Terraform module is free from CVE and stay compliance
- **automation**, run all above steps by using automation tool to improve development time and keep best quality before or after merging to Git repository


The tools:

- [terraform validate](https://developer.hashicorp.com/terraform/cli/commands)
- [terraform fmt](https://developer.hashicorp.com/terraform/cli/commands)
- [tflint](https://github.com/terraform-lint48ers/tflint)
- [tfsec](https://github.com/aquasecurity/tfsec)
- [Pre-commit](https://pre-commit.com/)
- Github Action [Setup Terraform pipeline](https://github.com/hashicorp/setup-terraform)

## E. How to contribute ?

If you find any issue, you can raise it here at our [Issue Tracker](https://github.com/ridwanbejo/terraform-mysql-admin/issues)

If you have something that you want to merge to this repo, just raise [Pull Requests](https://github.com/ridwanbejo/terraform-mysql-admin/pulls)

Ensure that you install all the tools from section D. for development purpose.
