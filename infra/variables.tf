variable "client_id" {
  default = "4af9eb18-7484-402a-82e1-e83486e6085f"
}
variable "client_secret" {
  default = "37d696d8-c2c9-41e9-8a59-caaa641b81ac"
}

variable "agent_count" {
  default = 3
}

# variable "ssh_public_key" {
#     default = "~/.ssh/id_rsa.pub"
# }

variable "dns_prefix" {
  default = "aks-k8s"
}

variable cluster_name {
  default = "aks-k8s"
}

variable resource_group_name {
  default = "aks-k8s"
}

variable location {
  default = "West Europe"
}

# variable log_analytics_workspace_name {
#     default = "testLogAnalyticsWorkspaceName"
# }

# # refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
# variable log_analytics_workspace_location {
#     default = "eastus"
# }

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
# variable log_analytics_workspace_sku {
#     default = "PerGB2018"
# }