variable "sql_server_name" {
  description = "The name of the SQL server"
  type        = string
}

variable "sql_db_name" {
  description = "The name of the SQL database"
  type        = string
}

variable "server_id" {
  description = "The ID of the Server"
  type = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the SQL server and database will be created"
  type        = string
}

variable "admin_login" {
  description = "The admin login name for the SQL server"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the SQL server"
  type        = string
}
