#!/usr/bin/env bash

## Script to redeploy Jenkins with new config

./generate_config.sh
kubectl delete ns jenkins
kubectl create ns jenkins
helm install -f /tmp/jenkins_values.yaml -n jenkins jenkins jenkinsci/jenkins
kubectl get all -n jenkins
./minikube-endpoint.sh
