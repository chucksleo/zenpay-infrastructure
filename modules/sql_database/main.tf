resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = "eastus"
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
}

resource "azurerm_mssql_database" "sql_database" {
  name           = var.sql_db_name
  server_id = azurerm_mssql_server.sql_server.id
  sku_name = "S0"

  tags = {
    environment = "development"
  }

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

