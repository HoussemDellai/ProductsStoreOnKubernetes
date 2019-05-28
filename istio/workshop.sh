# Install Istion on AKS
# https://docs.microsoft.com/en-us/azure/aks/istio-install

# This workshop was highly inspired by:
# https://docs.microsoft.com/en-us/azure/aks/istio-scenario-routing

kubectl create namespace products

kubectl label namespace products istio-injection=enabled

kubectl get ns voting -o yaml
# apiVersion: v1
# kind: Namespace
# metadata:
#   labels:
#     istio-injection: enabled    # will be considered by Istio
# ...

# deploy the v1.0 of the application
kubectl apply -n products -f mvc-app-v1.0.yaml
kubectl describe pod mvc-app-1-0-565fc694d8-q9rvr --namespace products
# ...
# Containers:
#   mvc-app:
#     Image:         houssemdocker/products-store-mvc:v1.0
#     ...
#   istio-proxy:
#     Image:         docker.io/istio/proxyv2:1.1.3
# ...

# deploy a Gateway to access the app
kubectl apply -n products -f mvc-app-gateway.yaml

# get the public IP address to access the app
kubectl get service istio-ingressgateway --namespace istio-system -o jsonpath='{.status.loadBalancer.ingress[0].ip}'

# deploy v1.1 and v2.0
kubectl apply -n products -f mvc-deployment.v1.1.yaml
kubectl apply -n products -f mvc-deployment.v2.0.yaml
