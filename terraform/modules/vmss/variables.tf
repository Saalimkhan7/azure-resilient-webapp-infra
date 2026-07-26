variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "admin_username" {
  description = "Admin username for VMSS instances"
  type        = string
}

variable "admin_password" {
  description = "Admin password for VMSS instances"
  type        = string
  sensitive   = true
}

variable "web_subnet_id" {
  description = "Subnet ID for VMSS network interface"
  type        = string
}

variable "backend_pool_id" {
  description = "Load balancer backend pool ID"
  type        = string
}