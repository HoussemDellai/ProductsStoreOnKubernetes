![Docker Image CI](https://github.com/HoussemDellai/ProductsStoreOnKubernetes/workflows/Docker%20Image%20CI/badge.svg)

# ProductsStoreOnKubernetes

This is a sample application used to demonstrate how to create dockerized apps and deploy them to Kubernetes cluster.  

It takes a sample ASP.NET Core MVC app, creates its Dockerfile, then the Kubernetes deployment objects.  

The Dockerfile is used to build the app from source code. Then runs the app inside a docker container.  
The k8s objects defined in YAML files are used to deploy the app into a Kubernetes cluster. These files are:  
1) mvc-deployment.local.yaml: used to create a Deployment and a Service to run the app.  
2) mssql-deployment.yaml: used to create a Deployment and a Service to run the SQL Server container.  
3) mssql-config-map.yaml: creates a ConfigMap object to store the database connection string as key-value pair. It is accessed by the app to retrieve the connection string as apass it as environment variable.  
4) mssql-secret.yaml: creates a Secret to securely save database connection string as key-value pair.  
5) mssql-pv.local.yaml: creates PersistentVolume and PersistentVolumeClaim objects in order to provision a storage space to save the database files.  

### 1) Introduction: Kubernetes and microservices

    1.1) The vision: Microservices on Docker containers on Kubernetes hosted on the Cloud and powered by DevOps.
    
<img src="https://github.com/HoussemDellai/ProductsStoreOnKubernetes/blob/master/images/k8s-architect.png?raw=true" width="80%"/>
Source: https://blog.nebrass.fr/playing-with-spring-boot-on-kubernetes/  


	1.2) Learn more about Kubernetes architecture:

<a href="https://www.youtube.com/watch?v=HJ6F05Pm5mQ">
<img src="https://github.com/HoussemDellai/ProductsStoreOnKubernetes/blob/master/images/k8s-objects.png?raw=true" width="80%"/>
</a>

	1.3) Learn more about Kubernetes objects (Deployment I Service I ConfigMap I Secret I PersistentVolume)

<a href="https://www.youtube.com/watch?v=pR-UlYf61uA">
<img src="https://github.com/HoussemDellai/ProductsStoreOnKubernetes/blob/master/images/k8s-explained.png?raw=true" width="80%"/>
</a>
	
### 2) Create docker containers  
	
    2.1) Introduction to Dockerfile: build, run  
         $ docker run hello-world  
           Hello from Docker!  
           This message shows that your installation appears to be working correctly.  
         $ cd MvcApp  
	2.2) $ docker build .     # don't forget the dot at the end to configure the context!  
         $ docker build --rm -f "Dockerfile" -t mvc-app:1.0 .   
	2.3) $ docker images  
	2.4) $ docker run --rm -d -p 5555:80/tcp mvc-app:1.0   
	2.5) $ docker ps  
	2.6) Open browser on localhost:5555 (app doesn't connect to database!!)  
	2.7) Configure and start SQL Server on container  
	2.8) $ docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=@Aa123456' -p 1433:1433 -d microsoft/mssql-server-linux:2017-CU8  

### 3) Run the App using docker-compose

	3.0) Open the docker-compose.yaml file
	3.1) $ docker-compose build
	3.2) $ docker-compose up
		 Starting sqldb-k8s     ... done
		 Starting mvcapp-k8s    ... done
	
### 4) Push containers to Docker Hub  
	
    4.1) Tag image, login, push  
	4.2) $ docker tag mvc-app:1.0 houssemdocker/mvc-app:1.0  # use your own Docker Hub ID  
	4.3) $ docker login  
	4.4) $ docker push houssemdocker/mvc-app:1.0  
         Check your hub.docker.io
	
### 5) Deploy to Kubernetes using the Dashboard  
	
    5.1) Start the Dashboard  
	5.2) $ minikube start  
	5.3) $ minikube dashboard  
	
### 6) Deploy to Kubernetes using kubectl cli  
	
    6.1) $ Kubectl run …  
	6.2) $ kubectl get deployments  
	6.3) $ kubectl get secrets  
	6.4) $ kubectl get services  
	
### 7) Deploy to kubernetes using configuration YAML files  

	7.1) $ kubectl apply -f mssql-secret.yaml  
	     $ kubectl get secrets   
	7.2) $ kubectl apply -f mssql-pv.local.yaml  
	     $ kubectl get pv  
	7.3) $ kubectl apply -f mssql-deployment.yaml  
	     $ kubectl get deployments  
	7.4  $ kubectl apply -f mvc-deployment.local.yaml  
	     $ kubectl get deployments  
	7.5) $ minikube config set memory 4096  # if we need to resize minikube  
	8.0) $ kubectl delete services,deployments,pvc,secrets --all -n default
	
### 8) Create managed Kubernetes cluster in Azure using AKS  

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
	8.4) $ kubectl create clusterrolebinding kubernetes-dashboard \      			   --clusterrole=cluster-admin \  
	               --serviceaccount=kube-system:kubernetes-dashboard  
	8.5) $ az aks browse \
			  --resource-group aks-k8s-rg \
			  --name aks-k8s \
			  --subscription "Microsoft Azure Sponsorship"  
	
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
