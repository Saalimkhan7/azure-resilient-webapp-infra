variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-webapp-infra-demo"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "centralindia"
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for VMs"
  type        = string
  sensitive   = true
}