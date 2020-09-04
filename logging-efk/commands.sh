# Get Helm Stable Repo
helm repo add stable https://kubernetes-charts.storage.googleapis.com

# Install Elasticsearch
helm install elasticsearch stable/elasticsearch

# Install Fluentd
kubectl apply -f logging-efk\fluentd-daemonset-elasticsearch.yaml

# Install Kibana
helm install kibana stable/kibana -f logging-efk\kibana-values.yaml