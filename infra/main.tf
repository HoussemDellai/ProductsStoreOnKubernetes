provider "azurerm" {
  version = ">=2.0"
  # The "feature" block is required for AzureRM provider 2.x.
  features {}
  # Get the following credentials by running the command:
  # az ad sp create-for-rbac --sdk-auth
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = "1.17.3"

  default_node_pool {
    name       = "default"
    node_count = var.agent_count
    vm_size    = "Standard_DS2_v2"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  role_based_access_control {
    enabled = false
  }

  network_profile {
    network_plugin = "kubenet"
    network_policy = "calico"
  }

  tags = {
    Environment = "Development"
  }
}

resource "azurerm_sql_server" "sql" {
  name                         = "mssql-paas"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "houssem"
  administrator_login_password = "@Aa123456"
}

resource "azurerm_storage_account" "storage" {
  name                     = "mssqlstorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_database" "db" {
  name                = "ProductsDB"
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
  name                = "AllowAzureServicesAndResourcesToAccessThisServer"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.sql.name
  # The Azure feature Allow access to Azure services can be enabled 
  # by setting start_ip_address and end_ip_address to 0.0.0.0
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}