![Docker Image CI](https://github.com/HoussemDellai/ProductsStoreOnKubernetes/workflows/Docker%20Image%20CI/badge.svg)

# ProductsStore on Kubernetes

This is a sample application used to demonstrate how to create dockerized apps and deploy them to Kubernetes cluster.  

It takes a sample ASP.NET Core MVC app, creates its Dockerfile, then the Kubernetes deployment objects.  

The Dockerfile is used to build the app from source code. Then runs the app inside a docker container.  
The k8s objects defined in YAML files are used to deploy the app into a Kubernetes cluster. These files are:  
1) **mvc-deployment.yaml**: used to create a Deployment and a Service to run the app.  
2) **mssql-deployment.yaml**: used to create a Deployment and a Service to run the SQL Server container.  
3) **mssql-config-map.yaml**: creates a ConfigMap object to store the database connection string as key-value pair. It is accessed by the app to retrieve the connection string as apass it as environment variable.  
4) **mssql-secret.yaml**: creates a Secret to securely save database connection string as key-value pair.  
5) **mssql-pv.azure.yaml**: creates PersistentVolume and PersistentVolumeClaim objects in order to provision a storage space to save the database files.  

### 1) Introduction: Kubernetes and microservices

    1.1) The vision: Microservices on Docker containers on Kubernetes hosted on the Cloud and powered by DevOps.
    
<img src="https://github.com/HoussemDellai/ProductsStoreOnKubernetes/blob/master/images/k8s-architect.png?raw=true" width="80%"/>
Source: https://blog.nebrass.fr/playing-with-spring-boot-on-kubernetes/  


    1.2) Learn more about Kubernetes architecture:

<a href="https://www.youtube.com/watch?v=pR-UlYf61uA">
<img src="https://github.com/HoussemDellai/ProductsStoreOnKubernetes/blob/master/images/k8s-explained.png?raw=true" width="80%"/>
</a>

    1.3) Learn more about Kubernetes objects: Deployment, Service, ConfigMap, Secret, PersistentVolume...

<a href="https://www.youtube.com/watch?v=HJ6F05Pm5mQ">
<img src="https://github.com/HoussemDellai/ProductsStoreOnKubernetes/blob/master/images/k8s-objects.png?raw=true" width="80%"/>
</a>
	
### 2) Create docker container  

Inside the MvcApp folder, we have a sample ASP.NET Core MVC application that displays web pages and connects to a Database. The goal here is to run this application in a Docker container. For that, we need the **Dockerfile** which describes the instructions to build/compile app from source code and deploy it into a base image that have .NET Core SDK and Runtime.  

2.0) Install Docker into your machine
Make sure you have Docker installed and running in your machine: <a href="https://www.docker.com/products/docker-desktop">Docker Desktop</a>
	
2.1) Start Docker in your machine and check if it runs successfully by deploying a sample image called hello-world:  
```console  
$ docker run hello-world  
  Hello from Docker!  
  This message shows that your installation appears to be working correctly.    
2.2) Create Docker image  
$ cd MvcApp  
$ docker build .     # don't forget the dot at the end to configure thecontext!  
$ docker build --rm -f "Dockerfile" -t mvc-app:1.0 .   
2.3) List the created image  
$ docker images  
2.4) Run the created image  
$ docker run --rm -d -p 5555:80/tcp mvc-app:1.0   
2.5) List the running image  
$ docker ps  
2.6) Open browser on localhost:5555 and note how the app doesn't connect to database despite it is configured to!!  
2.7) Configure and start SQL Server on container  
$ docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=@Aa123456' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-CU4-ubuntu-16.04  
```

### 3) Run the App using docker-compose

When dealing with multiple containers, Docker Compose becomes really useful. It allows to define the configuration in a single file. This file then will be used to build, deploy and stop all the images using docker-compose CLI. Open the **docker-compose.yaml** file. Note how we are defining 2 services: one to run the web app and a second one to deploy the database.  
```console
3.1) Build the Docker Compose file to create the images  
$ docker-compose build  
3.2) Run the Docker Compose file to run the created images  
$ docker-compose up  
  Starting sqldb-k8s     ... done  
  Starting mvcapp-k8s    ... done  
```

### 4) Push containers to Docker Hub  

Now that we have created the docker image in our machine, we want to deploy it into Kubernetes. But, Kubernetes should get that image through a Container Registry. Container Registry is a like a database for all our containers. We can use Azure ACR or Docker Hub... We'll continue with Docker Hub. Make sure you create a an account here <a href="https://hub.docker.com/">hub.docker.com</a> and take note of your Docker Hub ID (Registry name).  
```console
4.1) Create a variable to hold our Registry name  
$ $registry="REPLACE_WITH_YOUR_DOCKER_HUB_ID"  
4.2) Tag the image by appending the registry name  
$ docker tag mvc-app:1.0 $registry/mvc-app:1.0  
4.3) Login to Docker Hub and enter your login and password    
$ docker login  
4.4) Push the image into the registry  
$ docker push $registry/mvc-app:1.0  
4.5) Check your hub.docker.io, you should see the image uploaded into a repository
```

### 5) Deploy to Minikube/Kubernetes using the Dashboard  
	
```console
5.1) Start the Dashboard  
5.2) $ minikube start  
5.3) $ minikube dashboard  
```

### 6) Deploy to Kubernetes using Kubectl CLI  
	
```console
6.1) $ Kubectl run …  
6.2) $ kubectl get deployments  
6.3) $ kubectl get secrets  
6.4) $ kubectl get services  
```
	
### 7) Deploy to Kubernetes using configuration YAML files  

```console
7.1) $ kubectl apply -f mssql-secret.yaml  
     $ kubectl get secrets   
7.2) $ kubectl apply -f mssql-pv.azure.yaml  
     $ kubectl get pv  
7.3) $ kubectl apply -f mssql-deployment.yaml  
     $ kubectl get deployments  
7.4  $ kubectl apply -f mvc-deployment.azure.yaml  
     $ kubectl get deployments  
7.5) $ minikube config set memory 4096  # if we need to resize minikube  
7.6) $ kubectl delete services,deployments,pvc,secrets --all -n default
```

### 8) Create managed Kubernetes cluster in Azure using AKS  

```console
8.1) $ az group create \  
		  --location westeurope \  
		  --subscription "Microsoft Azure Sponsorship" \  
		  --name aks-k8s-rg  
8.2) $ az aks create \  
		  --generate-ssh-keys \  
		  --subscription "Microsoft Azure Sponsorship" \  
		  --node-count 1 \  
		  --resource-group aks-k8s-rg \  
		  --name aks-k8s   
8.3) $ az aks get-credentials \  
		  --resource-group aks-k8s-rg \  
		  --name aks-k8s \  
		  --subscription "Microsoft Azure Sponsorship" 
	 Merged "aks-k8s" as current context in /Users/houssem/.kube/config  
8.4) $ kubectl create clusterrolebinding kubernetes-dashboard \  
               --clusterrole=cluster-admin \  
               --serviceaccount=kube-system:kubernetes-dashboard  
8.5) $ az aks browse \
		  --resource-group aks-k8s-rg \
		  --name aks-k8s \
		  --subscription "Microsoft Azure Sponsorship"  
```

### 9) Create the CI/CD pipelines for using Azure DevOps   

<img src="https://github.com/HoussemDellai/ProductsStoreOnKubernetes/blob/master/images/ci-cd-aks.png?raw=true"/>

	9.1) CI pipeline: builds the container and pushes it to docker hub.  
<img src="https://github.com/HoussemDellai/ProductsStoreOnKubernetes/blob/master/images/kubernetes-ci.png?raw=true"/>

	9.2) CD pipeline: deploys the YAML manifest files into Kubernetes cluster.  
<img src="https://github.com/HoussemDellai/ProductsStoreOnKubernetes/blob/master/images/kubernetes-cd.png?raw=true"/>
	
### 10) Discussion points  
scalability, health check, mounting volume, resource limits, service discovery, deploy with Helm...  

### 11) More resources

eShopOnContainers: https://github.com/dotnet-architecture/eShopOnContainers

https://www.udemy.com/kubernetes-for-developers/
Please email me if you want a free coupon :)  

<a href="https://www.udemy.com/kubernetes-for-developers/">
<img src="https://github.com/HoussemDellai/ProductsStoreOnKubernetes/blob/master/images/udemy-courses.png?raw=true" width="90%"/>
</a>
