helm install elasticsearch stable/elasticsearch

kubectl apply -f logging-efk\fluentd-daemonset-elasticsearch.yaml

helm install kibana stable/kibana -f logging-efk\kibana-values.yaml