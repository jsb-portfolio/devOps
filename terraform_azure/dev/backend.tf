terraform {
  backend "azurerm" {
    resource_group_name  = "myTFResourceGroup"
    storage_account_name = "devstoracc" # Must be globally unique
    container_name       = "tfstatestorage-dev"
    key                  = "terraform.tfstate"
  }
}
