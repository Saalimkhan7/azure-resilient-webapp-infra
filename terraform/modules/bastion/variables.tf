variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "bastion_subnet_id" {
  description = "AzureBastionSubnet ID"
  type        = string
}