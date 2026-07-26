variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "mgmt_vm_id" {
  description = "Resource ID of the management VM to protect"
  type        = string
}