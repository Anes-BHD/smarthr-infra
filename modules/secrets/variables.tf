variable "project" {
  type = string
}

variable "db_host" {
  type      = string
  sensitive = true
}

variable "app_key" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}
