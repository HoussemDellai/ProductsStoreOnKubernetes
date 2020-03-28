
az ad sp create-for-rbac --sdk-auth --role contributor --name "sp-github-actions-ci-cd"

terraform init

terraform plan -out out.plan

terraform apply out.plan