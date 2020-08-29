# Setup the web url to test
$WEBAPP_URL='http://20.50.165.16'
# Start Load Test with Artillery
artillery quick --count 1000 -n 200 $WEBAPP_URL/Products

# Watch the Pods creation, on a new terminal
kubectl get pods -w