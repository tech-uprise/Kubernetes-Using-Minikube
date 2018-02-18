#!/usr/bin/env bash
echo
echo "Checking docker --version ---> " 
	docker --version                # Docker version 17.09.0-ce, build afdb6d4
echo
echo "Checking docker-compose --version ---> " 
	docker-compose --version        # docker-compose version 1.16.1, build 6d1ac21
echo
echo "Checking docker-machine --version ---> " 
	docker-machine --version        # docker-machine version 0.12.2, build 9371605
echo
echo "Checking minikube version ---> " 
	minikube version                # minikube version: v0.22.3
echo
echo "Checking minikube status ---> " 
	minikube status               
echo
echo "Checking docker-machine status ---> "
	docker-machine status               
echo
echo "Checking kubectl version --client ---> "
	kubectl version --client        
	# Client Version: version.Info{Major:"1", Minor:"8", GitVersion:"v1.8.1", GitCommit:"f38e43b221d08850172a9a4ea785a86a3ffa3b3a", 
	#GitTreeState:"clean", BuildDate:"2017-10-12T00:45:05Z", GoVersion:"go1.9.1", Compiler:"gc", Platform:"darwin/amd64"}      
echo
echo "Checking k8s status ---> "
	kubectl get nodes              
echo
