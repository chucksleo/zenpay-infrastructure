variable "nic_name" {
  description = "The name of the network interface"
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "location" {
  description = "The Azure region where the virtual machine will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "network_security_group_id" {
  description = "The ID of the network security group"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
}

variable "availability_set_id" {
  description = "The ID of the availability set"
  type        = string
}

variable "os_disk_name" {
  description = "The name of the OS disk"
  type        = string
}

variable "os_disk_size" {
  description = "The size of the OS disk in GB"
  type        = number
}

variable "computer_name" {
  description = "The name of the computer"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the virtual machine"
  type        = string
}
