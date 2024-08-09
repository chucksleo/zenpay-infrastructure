data "azurerm_client_config" "current" {}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = "assessment-rg"
  location = "East US"
}

module "virtual_network" {
  source              = "./modules/virtual_network"
  name                = "assessment-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
}

module "web_subnet" {
  source           = "./modules/subnet"
  name             = "web-tier-subnet"
  address_prefixes = ["10.0.1.0/24"]
  # location            = module.resource_group.location
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.virtual_network.name
}

module "db_subnet" {
  source           = "./modules/subnet"
  name             = "db-tier-subnet"
  address_prefixes = ["10.0.2.0/24"]
  # location             = module.resource_group.location
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.virtual_network.name
}

module "web_nsg" {
  source              = "./modules/network_security_group"
  name                = "web-tier-nsg"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  security_rules = [
    {
      name                       = "allow_http"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow_https"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

module "db_nsg" {
  source              = "./modules/network_security_group"
  name                = "db-tier-nsg"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  security_rules = [
    {
      name                       = "allow_sql"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "*"
    }
  ]
}

module "web_vms" {
  source                    = "./modules/virtual_machine"
  nic_name                  = "web-tier-nic"
  vm_name                   = "web-tier-vm"
  location                  = module.resource_group.location
  resource_group_name       = module.resource_group.name
  subnet_id                 = module.web_subnet.id
  network_security_group_id = module.web_nsg.id
  vm_size                   = "Standard_D2s_v3"
  availability_set_id       = null # If you create an availability set, pass its ID here
  os_disk_name              = "web-os-disk"
  os_disk_size              = 128
  computer_name             = "web-tier-vm"
  admin_username            = "adminuser"
  admin_password            = "P@ssw0rd1234!"
}

module "db_vm" {
  source                    = "./modules/virtual_machine"
  nic_name                  = "db-tier-nic"
  vm_name                   = "db-tier-vm"
  location                  = module.resource_group.location
  resource_group_name       = module.resource_group.name
  subnet_id                 = module.db_subnet.id
  network_security_group_id = module.db_nsg.id
  vm_size                   = "Standard_D4s_v3"
  availability_set_id       = null # If you create an availability set, pass its ID here
  os_disk_name              = "db-os-disk"
  os_disk_size              = 256
  computer_name             = "db-tier-vm"
  admin_username            = "adminuser"
  admin_password            = "P@ssw0rd1234!"
}

module "load_balancer" {
  source              = "./modules/load_balancer"
  public_ip_name      = "lb-public-ip"
  lb_name             = "assessment-lb"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
}

module "application_gateway" {
  source              = "./modules/application_gateway"
  public_ip_name      = "app-gateway-public-ip"
  app_gateway_name    = "assessment-app-gateway"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.web_subnet.id
}

module "sql_database" {
  source              = "./modules/sql_database"
  sql_server_name     = "assessment-sql-server"
  sql_db_name         = "assessment-sql-db"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  server_id = module.sql_database.sql_server_id
  # server_id = module.mssql_server.sql_server_id
  # db_name         = "assessment-sql-db"
  admin_login    = "sqladmin"
  admin_password = "P@ssw0rd1234!"
}

module "key_vault" {
  source              = "./modules/key_vault"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  key_vault_name      = "assessment-kv"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  secret_name         = "sql-connection-string"
  secret_value        = module.sql_database.sql_server_name
}

module "backup" {
  source              = "./modules/backup"
  vault_name          = "assessment-backup-vault"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  policy_name         = "assessment-backup-policy"
  resource_vault_name = "assessment-resource-vault"
  recovery_vault_name = "assesement-recovery-vault"

  vm_ids = { "web1" = module.web_vms.vm_id, "db1" = module.db_vm.vm_id }
}
