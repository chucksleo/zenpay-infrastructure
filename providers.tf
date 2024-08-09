# provider "azurerm" {
#   features {}
# }
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"  # Adjust version as needed
    }
  }
}

provider "azurerm" {
  features {}
  use_msi = false
}
