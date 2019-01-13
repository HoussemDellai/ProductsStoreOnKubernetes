# ProductsStoreOnKubernetes

1) Introduction: Kubernetes and microservices
1.1) Microservices on Docker containers on Kubernetes hosted on the Cloud and powered by DevOps
	
2) Create docker containers
	1) Introduction to Docker file: build, run
	2) $ docker build -name mvc-app .
	3) $ docker images
	4) $ docker run -p 5000:80 mvc-app
	5) $ docker ps
	6) Open browser (app doesn't connect to database!!)
	7) Configure and start SQL Server on container
	8) $ docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=@Aa123456' -p 1433:1433 -d microsoft/mssql-server-linux:2017-CU8
	
3) Push containers to Docker Hub
	1) Tag image, login, push
	2) $ docker tag mvc-app -t houssemdocker/mvc-app:1.0
	3) $ docker login
	4) $ docker push houssemdocker/mvc-app:1.0
	
4) Deploy to Kubernetes using the Dashboard
	1) Start the Dashboard
	2) $ minikube start
	3) $ minikube dashboard
	
5) Deploy to Kubernetes using kubectl cli
	1) $ Kubectl run …
	2) $ kubectl get deployments
	3) $ kubectl get secrets
	4) $ kubectl get services
	
6) Deploy to kubernetes using configuration YAML files
	1) $  kubectl apply -f mssql-secret.yaml 
	2) $  kubectl apply -f mssql-pv.local.yaml 
	3) $ kubectl apply -f mssql-deployment.yaml
	4) $ minikube config set memory 4096
	
7) Création des pipelines CI/CD avec Azure DevOps
	1) CI pipeline
	2) CD pipeline
	
8) Discussion points: Scalability, Health Check


This repository serves for the online training on Udemy: https://www.udemy.com/kubernetes-for-developers/
Please email me if you want a free coupon :)
