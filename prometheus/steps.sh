// docs: https://linuxacademy.com/blog/kubernetes/running-prometheus-on-kubernetes/

kubectl apply -f namespace.yaml
kubectl apply -f clusterRole.yaml
kubectl apply -f configmap.yaml
kubectl apply -f prometheus-deployment.yaml

kubectl get pods -n monitoring
kubectl get services -n monitoring


#########################################

$ helm install stable/prometheus --name my-prometheus --set server.service.type=LoadBalancer --set rbac.create=false
