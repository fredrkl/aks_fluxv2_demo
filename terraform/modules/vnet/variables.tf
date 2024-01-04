variable "vnet_name_second" {
  type        = string
  description = "The name of the second virtual network"
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"

  validation {
    condition     = length(var.resource_group_name) <= 30
    error_message = "The resource group name must be less than 30 characters"
  }
}
