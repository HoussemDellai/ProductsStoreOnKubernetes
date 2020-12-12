set -e

export LOCATION="__LOCATION__"
export INFRA_RESOURCE_GROUP="__INFRA_RESOURCE_GROUP__"
export TF_STATE_STORAGE_ACCOUNT_NAME="__TF_STATE_STORAGE_ACCOUNT_NAME__"
export TF_STATE_CONTAINER_NAME="__TF_STATE_CONTAINER_NAME__"
# export KEYVAULT_NAME="__KEYVAULT_NAME__"

# export LOCATION="westeurope"
# export INFRA_RESOURCE_GROUP="AppInfraRG"
# export TF_STATE_STORAGE_ACCOUNT_NAME="appstoragetfstate"
# export TF_STATE_CONTAINER_NAME="appcontainertfstate"
# export KEYVAULT_NAME="app-keyvault-ci"
 
# Create the resource group
az group create -n $INFRA_RESOURCE_GROUP -l $LOCATION
 
echo "Resource group $INFRA_RESOURCE_GROUP created."
 
# Create the storage account
az storage account create -g $INFRA_RESOURCE_GROUP -l $LOCATION \
  --name $TF_STATE_STORAGE_ACCOUNT_NAME \
  --sku Standard_LRS \
  --encryption-services blob
 
echo "Storage account $TF_STATE_STORAGE_ACCOUNT_NAME created."
 
# Retrieve the storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $INFRA_RESOURCE_GROUP --account-name $TF_STATE_STORAGE_ACCOUNT_NAME --query [0].value -o tsv)
 
echo "Storage account key retrieved."
 
# Create a storage container (for the Terraform State)
az storage container create --name $TF_STATE_CONTAINER_NAME --account-name $TF_STATE_STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY
 
echo "Storage container $TF_STATE_CONTAINER_NAME created."
 
# Create an Azure KeyVault
# az keyvault create -g $INFRA_RESOURCE_GROUP -l $LOCATION --name $KEYVAULT_NAME
# echo "Key vault $KEYVAULT_NAME created."
 
# Store the Terraform State Storage Key into KeyVault
# az keyvault secret set --name tfstate-storage-key --value $ACCOUNT_KEY --vault-name $KEYVAULT_NAME
 
# echo "Key vault secret created."
 
# Display information
echo "Azure Storage Account and KeyVault have been created."
##echo "terraform init -backend-config=\"storage_account_name=$TF_STATE_STORAGE_ACCOUNT_NAME\" 
# -backend-config=\"container_name=$TF_STATE_CONTAINER_NAME\" 
# -backend-config=\"access_key=\$(az keyvault secret show --name tfstate-storage-key --vault-name $KEYVAULT_NAME --query value -o tsv)\" 
# -backend-config=\"key=terraform-ref-architecture-tfstate\""
