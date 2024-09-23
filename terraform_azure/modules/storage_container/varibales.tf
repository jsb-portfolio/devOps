variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}
variable "location" {
  description = "The location/region where the resource group and resources will be created."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the Storage Account. Must be globally unique."
  type        = string
}

variable "storage_container_name" {
  description = "The name of the Storage Container."
  type        = string
}
