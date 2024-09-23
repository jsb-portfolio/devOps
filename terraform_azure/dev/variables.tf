# provider.tf
variable "subscription_id" {
  description = "The ID of the Azure subscription obtained from az account list"
  type        = string
}

# resource_group.tf
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}
variable "resource_group_location" {
  description = "The location/region where the resource group and resources will be created."
  type        = string
}

# Define other variables specific to your environment

# Blob Storage
variable "storage_account_name" {
  description = "The name of the Storage Account. Must be globally unique."
  type        = string
}
variable "storage_container_name" {
  description = "The name of the Storage Container."
  type        = string
}

# PostgreSQL
variable "administrator_login" {
  description = "The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}
variable "administrator_password" {
  description = "The Password for the PostgreSQL Server. Needs to be at least 8 characters long."
  type        = string
}