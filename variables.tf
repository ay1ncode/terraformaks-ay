variable "resource_group_name" {
  type = string
  description = "Resource group in azure"
}

variable "location" {
  type = string
  description = "location to deploy resource"
}

variable "kubernetes_version" {
  type = string
  description = "kubernetes version"
}
variable "cluster_name" {
  type = string
  description = "Aks cluster name"
}
variable "system_node_count" {
  type = number
  description = "node number count"
}
variable "acr_name" {
  type = string
  description = "Name of repository"
}
