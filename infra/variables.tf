// variable client_id {
//   default = "40360d8a-0ef9-4719-8510-1faf083cbba4"
// }
// variable client_secret {
//   default = "84d9c342-2805-4e7f-8d5e-8d3566921dd4"
// }
// variable tenant_id {
//   default = "72f988bf-86f1-41af-91ab-2d7cd011db47"
// }
// variable subscription_id {
//   default = "4b72ed90-7ca3-4e76-8d0f-31a2c0bee7a3"
// }

variable agent_count {
  default = 1
}

variable dns_prefix {
  default = "aks-k8s-2020"
}

variable cluster_name {
  default = "aks-k8s-2020"
}

variable acr_name {
  default = "acrforaks2020"
}

variable sql_name {
  default = "mssql-2020"
}

variable db_name {
  default = "ProductsDB"
}

variable db_admin_login {
  default = "houssem"
}

variable db_admin_password {
  default = "@Aa123456"
}

variable storage_name {
  default = "mssqlstorageaccount2020"
}

variable resource_group_name {
  default = "aks-k8s-2020"
}

variable location {
  default = "westeurope"
}
