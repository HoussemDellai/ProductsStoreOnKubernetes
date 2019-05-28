# Use az ad sp to generate a Service Principal in Azure
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/YOUR_AZURE_SUBSCRIPTION_ID"
# Output is like:
# Retrying role assignment creation: 1/36
# {
#   "appId": "42491d86-af2f-4b58-aab4-xxxxxxxxxxx",
#   "displayName": "azure-cli-2019-05-26-11-49-19",
#   "name": "http://azure-cli-2019-05-26-11-49-19",
#   "password": "c741c9c3-c4f1-4c42-a615-xxxxxxxxxx",
#   "tenant": "558506eb-9459-4ef3-b920-xxxxxxxxxxxxxx"
# }
