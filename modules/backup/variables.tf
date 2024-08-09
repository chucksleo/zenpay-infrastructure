variable "vault_name" {
  description = "The name of the backup vault"
  type        = string
}

variable "policy_name" {
  description = "The name of the backup policy"
  type        = string
}

variable "location" {
  description = "The location of the backup vault"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "vm_ids" {
  description = "The IDs of the virtual machines to back up"
  type        = map(string)
}

variable "resource_vault_name" {
  description = "The name of the resource vault"
  type        = string
}

variable "recovery_vault_name" {
  description = "The name of the recovery vault"
  type = string
}