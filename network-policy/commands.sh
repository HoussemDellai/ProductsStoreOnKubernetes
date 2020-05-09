kubectl create namespace development
kubectl label namespace/development purpose=development

kubectl run backend --image=nginx --labels app=webapp,role=backend --namespace development --expose --port 80 --generator=run-pod/v1