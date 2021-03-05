#!/usr/bin/env bash

## Script to redeploy Jenkins with new config

./generate_config.sh
kubectl delete ns jenkins
kubectl create ns jenkins
helm install jenkins jenkinsci/jenkins -f /tmp/jenkins_values.yaml  --namespace jenkins --version 3.2.0
./minikube-endpoint.sh
