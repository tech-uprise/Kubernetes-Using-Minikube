#!/usr/bin/env bash
echo
echo "Creating Deployments and Services for the docker containers to run in Kubernetes..."
echo
	kubectl create -f elasticservice-deployment.yaml
echo 
	kubectl get deployments elasticservice
echo

echo
	kubectl create -f registerservice-deployment.yaml 
echo
echo 
	kubectl get deployments registerservice
echo

echo
	kubectl create -f kibanaservice-deployment.yaml 
echo
echo 
	kubectl get deployments kibanaservice
echo

echo
echo "Creating Services and exposing for the docker containers..."

echo
	kubectl expose deployment elasticservice --type=LoadBalancer --name=elasticservice
echo 
	kubectl get services elasticservice
echo

echo
	kubectl expose deployment registerservice --type=LoadBalancer --name=registerservice
echo 
	kubectl get services registerservice
echo

echo
	kubectl expose deployment kibanaservice --type=LoadBalancer --name=kibanaservice
echo 
	kubectl get services kibanaservice
echo


echo "Sleeping for 10 seconds for the services and pods to initialize and create..."
echo
echo "checking to see if everything is up and running...kubectl get all"
	kubectl get all

echo "Launching minikube dashboard from default browser"
minikube dashboard

echo "Getting register service url"
minikube service spring-elastic-kibana --url

echo "Launching register service UI from default browser"
minikube service registerservice

echo "Launching Kibana UI from default browser"
minikube service kibanaservice

