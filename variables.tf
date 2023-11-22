variable "databases" {
  type = list(object({
    name                  = string
    default_character_set = optional(string)
    default_collation     = optional(string)
  }))
}

variable "users" {
  type = list(object({
    user = string
    host = string
    grant = optional(object({
      database   = string
      privileges = list(string)
    }))
  }))
}
