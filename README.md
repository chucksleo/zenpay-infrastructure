# zenpay-infrastructure
This repo contains Reusable Terraform Modules to provision several resources Azure for a Two-tier Architecture for Zenpay, It also includes modules for Backup, Key-vault to help manage the Infrastructure better.

# Terraform Modules for Azure Infrastructure 

## Overview
This repository contains Terraform modules to deploy infrastructure on Microsoft Azure. The modules cover creating a Virtual Network (VNet) with subnets, Network Interfaces, Virtual Machines, SQL Databases, and other resources.

## Prerequisites
* Terraform: Ensure Terraform is installed on your local machine or use the Azure Cloud Shell.
* Azure CLI: Install the Azure CLI for authentication and resource management.

## Authentication
1. Using Azure CLI:
* Run az login to authenticate.
* Ensure you have the appropriate permissions to create  resources in Azure.
2. Cloud Shell:
* If using Azure Cloud Shell, you are already authenticated.

## Modules
### 1. Virtual Network and Subnets
Module Name: `virtual_network`

This module creates a Virtual Network (VNet) with two subnets: Web Tier and Database Tier.

### Usage:
``module "virtual_network" {
  source              = "./modules/virtual_network"
  resource_group_name = "your-resource-group-name"
  vnet_name           = "your-vnet-name"
  address_space       = ["10.0.0.0/16"]
  web_tier_prefix     = "10.0.1.0/24"
  db_tier_prefix      = "10.0.2.0/24"
}``

### Variables:
* `resource_group_name`: The name of the resource group where the NIC will be created.
* `vnet_name`: The name of the Virtual Network.
* `address_space`: The address space for the VNet.
* `web_tier_prefix`: The address prefix for the Web Tier subnet.
* `db_tier_prefix`: The address prefix for the Database Tier subnet.

### 2. Network Interface
Module Name: `network_interface`

This module creates a Network Interface (NIC) that can be associated with a Virtual Machine.

### Usage:
``module "network_interface" {
  source              = "./modules/network_interface"
  resource_group_name = "your-resource-group-name"
  vnet_name           = "your-vnet-name"
  subnet_name         = "web-tier-subnet"  # Or "database-tier-subnet"
  nic_name            = "your-nic-name"
}``

### Variables:

* `resource_group_name`: The name of the resource group where the NIC will be created.
* `vnet_name`: The name of the Virtual Network where the NIC will be used.
* `subnet_name`: The name of the subnet the NIC will be associated with.
* `nic_name`: The name of the Network Interface.

### 3. Virtual Machine
Module Name: virtual_machine

This module creates a Virtual Machine in Azure.

### Usage:
``module "virtual_machine" {
  source              = "./modules/virtual_machine"
  resource_group_name = "your-resource-group-name"
  vm_name             = "your-vm-name"
  nic_id              = module.network_interface.nic_id
  size                = "Standard_DS1_v2"
  image               = "Canonical:UbuntuServer:18.04-LTS:latest"
  admin_username      = "adminuser"
  admin_password      = "adminpassword"
}``
