resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
}

resource "azurerm_key_vault_secret" "secret" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = azurerm_key_vault.kv.id
}

output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "secret_id" {
  value = azurerm_key_vault_secret.secret.id
}
