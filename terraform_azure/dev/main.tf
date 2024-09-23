resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "storage" {
  source = "../modules/storage_container"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  storage_account_name   = var.storage_account_name # Must be globally unique
  storage_container_name = var.storage_container_name
}