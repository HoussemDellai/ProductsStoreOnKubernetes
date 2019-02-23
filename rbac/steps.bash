mkdir cert

cd  cert/

# generate .key
openssl genrsa -out houssem.key 2048

# generate .csr
openssl req -new \
    -key houssem.key \
    -out houssem.csr \
    -subj "/CN=houssem/O=eralabs"

ls ~/.minikube/
# Check that the files ca.crt and ca.key exist in the location.

# generate .crt
openssl x509 -req \
    -in houssem.csr \
    -CA ~/.minikube/ca.crt \
    -CAkey ~/.minikube/ca.key \
    -CAcreateserial \
    -out houssem.crt \
    -days 500

kubectl config set-credentials houssem \
    --client-certificate=cert/houssem.crt \
    --client-key=cert/houssem.key

kubectl config set-context houssem-context \
    --cluster=minikube \
    --namespace=office \
    --user=houssem

kubectl config use-context houssem-context

kubectl config use-context minikube
