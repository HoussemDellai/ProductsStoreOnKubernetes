# Install Prometheus using helm Charts
$ helm install stable/prometheus --name my-prometheus --set server.service.type=LoadBalancer --set rbac.create=false

$ helm get manifest my-prometheus

# View the content of the prometheus.yml file within the Prometheus Server Pod
$ kubectl exec -it my-prometheus-server-5c54b66788-x87f4 -c prometheus-server -- cat /etc/config/prometheus.yml 

# Edit prometheus-server Secret
  static_configs:
  - targets:
    - localhost:9090
    - mvc-service # Add service name to the targets list

$ helm upgrade my-prometheus stable/prometheus --set server.service.type=LoadBalancer --set rbac.create=false --set serverFiles.prometheus.yml.scrape_configs.static_configs.targets="localhost:9091" 

# Install Grafana using Helm Charts
$ helm install --name my-grafana stable/grafana --set rbac.create=false --set service.type=LoadBalancer --set persistence.enabled=true


# Get your 'admin' user password by running:
# kubectl get secret --namespace default my-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
# gN1pVaGFV79amZZyONNSo5odlv6vzAWnBdZeqApz