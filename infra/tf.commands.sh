
az ad sp create-for-rbac --name "azure-sp-github-actions-ci-cd" --role owner --sdk-auth

terraform fmt

terraform init

terraform validate

terraform plan -out out.plan -var-file="terraform.local.tfvars"

terraform apply out.plan