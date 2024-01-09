variable "resource_group_name" {
  type        = string
  description = "The name of the storage account"
}
#
#variable "cluster_name" {
#  type        = string
#  description = "cluster name"
#}
#
variable "admin_group_object_id" {
  type        = string
  description = "admin group object id"
}

variable "location" {
  type        = string
  description = "location"
}
#
#variable "node_count" {
#  type        = number
#  description = "node count"
#}
#
#variable "node_size_vm_size" {
#  type        = string
#  description = "node size"
#}
#
#variable "kubernetes_version" {
#  type        = string
#  description = "kubernetes version"
#}
