variable "public_ip_name" {
  description = "The name of the public IP address"
  type        = string
}

variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "location" {
  description = "The Azure region where the load balancer will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
