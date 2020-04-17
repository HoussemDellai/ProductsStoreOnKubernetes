
docker build --rm -f "Dockerfile" -t acrsec.azurecr.io/webapp:1.0 .

docker run --rm -d -p 5555:80/tcp acrsec.azurecr.io/webapp:1.0

docker push acrsec.azurecr.io/webapp:1.0