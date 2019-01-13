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

1) Introduction: Kubernetes and microservices

    1.1) Microservices on Docker containers on Kubernetes hosted on the Cloud and powered by DevOps
	
2) Create docker containers  
	
    2.1) Introduction to Docker file: build, run  
	2.2) $ docker build .     # don't forget the dot at the end to configure the context!
         Successfully built d9d355827311 # this container ID won't be the same in your machine!  
	2.3) $ docker images  
	2.4) $ docker run -p 5000:80 d9d355827311 --name mvc-app  # use your generated container ID
	2.5) $ docker ps  
	2.6) Open browser on localhost:5000 (app doesn't connect to database!!)  
	2.7) Configure and start SQL Server on container  
	2.8) $ docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=@Aa123456' -p 1433:1433 -d microsoft/mssql-server-linux:2017-CU8  
	
3) Push containers to Docker Hub  
	
    3.1) Tag image, login, push  
	3.2) $ docker tag mvc-app -t houssemdocker/mvc-app:1.0  
	3.3) $ docker login  
	3.4) $ docker push houssemdocker/mvc-app:1.0  
	
4) Deploy to Kubernetes using the Dashboard  
	
    4.1) Start the Dashboard  
	4.2) $ minikube start  
	4.3) $ minikube dashboard  
	
5) Deploy to Kubernetes using kubectl cli  
	
    5.1) $ Kubectl run …  
	5.2) $ kubectl get deployments  
	5.3) $ kubectl get secrets  
	5.4) $ kubectl get services  
	
6) Deploy to kubernetes using configuration YAML files  

	6.1) $  kubectl apply -f mssql-secret.yaml   
	6.2) $  kubectl apply -f mssql-pv.local.yaml  
	6.3) $ kubectl apply -f mssql-deployment.yaml  
	6.4) $ minikube config set memory 4096  
	
7) Création des pipelines CI/CD avec Azure DevOps   

	7.1) CI pipeline  
	7.2) CD pipeline  
	
8) Discussion points: Scalability, Health Check  


This repository serves for the online training on Udemy:   https://www.udemy.com/kubernetes-for-developers/
Please email me if you want a free coupon :)  
