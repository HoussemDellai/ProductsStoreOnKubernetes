# Install Prometheus using helm Charts
$ helm install stable/prometheus --name my-prometheus --set server.service.type=LoadBalancer --set rbac.create=false

# Upgrade Prometheus configuartion, to scrape from the app's Service
$ helm upgrade my-prometheus stable/prometheus --set server.service.type=LoadBalancer --set rbac.create=false -f prometheus.values.yaml

$ helm get manifest my-prometheus

# View the content of the prometheus.yml file within the Prometheus Server Pod
$ kubectl exec -it my-prometheus-server-7f577785fc-f8mfq -c prometheus-server -- cat /etc/config/prometheus.yml

# Edit prometheus-server Secret
  static_configs:
  - targets:
    - localhost:9090
    - mvc-service # Add service name to the targets list

# $ helm upgrade my-prometheus stable/prometheus --set server.service.type=LoadBalancer --set rbac.create=false --set serverFiles.prometheus.yml.scrape_configs.static_configs.targets="localhost:9091" 
# Helm rolls out the minimum change possible, so all it will do is distribute the config to the existing Prometheus containers and reload them. --web.enable_lifecycle is active by default in helm version of Prom.

# Install Grafana using Helm Charts
$ helm install --name my-grafana stable/grafana --set rbac.create=false --set service.type=LoadBalancer --set persistence.enabled=true


# Get your 'admin' user password by running:
# kubectl get secret --namespace default my-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
# gN1pVaGFV79amZZyONNSo5odlv6vzAWnBdZeqApz