resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = "1.17.9"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
  # service_principal {
  #   client_id     = var.client_id
  #   client_secret = var.client_secret
  # }

  role_based_access_control {
    enabled = true
  }

  network_profile {
    network_plugin = "kubenet"
    network_policy = "calico"
  }

  tags = {
    Environment = "Development"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_sql_server" "sql" {
  name                         = var.sql_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.db_admin_login
  administrator_login_password = var.db_admin_password
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_database" "db" {
  name                = var.db_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sql.name
  create_mode         = "Default"
  edition             = "Standard"

  tags = {
    environment = "production"
  }
}

resource "azurerm_sql_firewall_rule" "rule" {
  name                = "AllowAzureServicesAndResources"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.sql.name
  # The Azure feature Allow access to Azure services can be enabled 
  # by setting start_ip_address and end_ip_address to 0.0.0.0
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

data "azurerm_client_config" "current" {
}

data "azurerm_user_assigned_identity" "identity" {
  name                = "${azurerm_kubernetes_cluster.k8s.name}-agentpool"
  resource_group_name = azurerm_kubernetes_cluster.k8s.node_resource_group
}

resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = data.azurerm_user_assigned_identity.identity.principal_id
  skip_service_principal_aad_check = true
}