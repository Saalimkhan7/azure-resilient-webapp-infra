variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "admin_username" {
  description = "Admin username for management VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for management VM"
  type        = string
  sensitive   = true
}

variable "app_subnet_id" {
  description = "App subnet ID for management VM NIC"
  type        = string
}