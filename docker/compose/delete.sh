#!/usr/bin/env bash

echo
echo

echo "List of Deployment, Services, Pods and PersistentVolumeClaims running..."

echo 
echo kubectl get all

echo

echo "Deleting Services..."
kubectl delete svc registerservice
kubectl delete svc kibanaservice
kubectl delete svc elasticservice

echo 

echo "Deleting Pods..."
kubectl delete pod registerservice
kubectl delete pod kibanaservice
kubectl delete pod elasticservice

echo 

echo "Deleting Pods..."
kubectl delete deployment registerservice
kubectl delete deployment kibanaservice
kubectl delete deployment elasticservice

echo 

echo "Deleting PersistentVolumeClaims..."
kubectl delete pvc registerservice 
kubectl delete pvc kibanaservice
kubectl delete pvc elasticservice

echo 

echo "Deleting rs..."
kubectl delete rs registerservice 
kubectl delete rs kibanaservice
kubectl delete rs elasticservice


echo
echo
echo "List of Deployment, Services, Pods and PersistentVolumeClaims running... after deleting..."
sleep 2
echo
echo kubectl get all
echo



