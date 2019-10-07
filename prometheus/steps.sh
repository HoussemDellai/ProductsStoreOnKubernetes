# Install Prometheus using helm Charts
$ helm install stable/prometheus --name my-prometheus --set server.service.type=LoadBalancer --set rbac.create=false

# View the content of the prometheus.yml file within the Prometheus Server Pod
$ kubectl exec -it my-prometheus-server-5c54b66788-x87f4 -c prometheus-server -- cat /etc/config/prometheus.yml

# Edit prometheus-server Secret
  static_configs:
  - targets:
    - localhost:9090
    - mvc-service # Add service name to the targets list
