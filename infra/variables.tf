variable "client_id" {
  default = "40360d8a-0ef9-4719-8510-1faf083cbba4"
}
variable "client_secret" {
  default = "84d9c342-2805-4e7f-8d5e-8d3566921dd4"
}
variable "tenant_id" {
  default = "72f988bf-86f1-41af-91ab-2d7cd011db47"
}
variable "subscription_id" {
  default = "4b72ed90-7ca3-4e76-8d0f-31a2c0bee7a3"
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