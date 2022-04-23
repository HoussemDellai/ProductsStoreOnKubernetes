variable "node_count" {
  default = 3
}

variable "dns_prefix" {
  default = "aks-k8s-2022"
}

variable "cluster_name" {
  default = "aks-k8s-2022"
}

variable "kubernetes_version" {
  default = "1.21.2"
}

variable "acr_name" {
  default = "acrforaks2022"
}

variable "sql_name" {
  default = "mssql-2022"
}

variable "db_name" {
  default = "ProductsDB"
}

variable "db_admin_login" {
  default = "houssem"
}

variable "db_admin_password" {
  default = "@Aa123456"
}

variable "storage_name" {
  default = "mssqlstorageaccount2022"
}

variable "resource_group_name" {
  default = "aks-k8s-2020"
}

variable "location" {
  default = "westeurope"
}
