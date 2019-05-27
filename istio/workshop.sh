kubectl create namespace products

kubectl label namespace products istio-injection=enabled

kubectl get ns voting -o yaml
# apiVersion: v1
# kind: Namespace
# metadata:
#   creationTimestamp: "2019-05-27T14:17:59Z"
#   labels:
#     istio-injection: enabled
#   name: products
#   resourceVersion: "7881"
#   selfLink: /api/v1/namespaces/products
#   uid: 3b235de6-808a-11e9-9ec6-0a58ac1f1263
# spec:
#   finalizers:
#   - kubernetes
# status:
#   phase: Active

kubectl apply -n products -f mssql-secret.yaml
kubectl apply -n products -f mssql-pv.azure.yaml
kubectl apply -n products -f mssql-deployment.yaml
kubectl apply -n products -f mvc-deployment.azure.yaml
