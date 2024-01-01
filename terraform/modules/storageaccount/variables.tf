#variable "resource_group" {
#  type = object({
#    name     = string
#    location = string
#    id       = string })
#  description = "The resource group object"
#}

variable "resource_group_name" {
  type        = string
  description = "The name of the storage account"
}
