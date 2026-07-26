variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vmss_id" {
  description = "Resource ID of the VMSS to monitor"
  type        = string
}