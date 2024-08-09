resource "azurerm_recovery_services_vault" "backup_vault" {
  name = "assessement-backup-vault"
  location = var.location
  resource_group_name = var.resource_group_name
  sku = "Standard"
}

resource "azurerm_backup_policy_vm" "backup_policy" {
  name = "assessement-backup-vault"
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.resource_group_name

  backup {
    frequency  = "Daily"
    time       = "23:00"
  }
  retention_daily {
    count = 7
  }
  retention_weekly {
    count = 42
    weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
  }
  retention_monthly {
    count = 12
    weekdays = ["Sunday", "Wednesday"]
    weeks = ["First", "Last"]
  }
  retention_yearly {
    count = 77
    weekdays = ["Sunday"]
    weeks = ["Last"]
    months = ["January"]
  }
}


