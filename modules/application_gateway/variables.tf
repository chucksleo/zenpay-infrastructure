variable "public_ip_name" {
  description = "The name of the public IP address"
  type        = string
}

variable "app_gateway_name" {
  description = "The name of the application gateway"
  type        = string
}

variable "location" {
  description = "The Azure region where the application gateway will be created"
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
