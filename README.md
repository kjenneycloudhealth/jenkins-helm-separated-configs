# jenkins-helm-separated-configs

## Requirements

* Helm (`brew install helm`)
* yq (`brew install yq`)

## Configuration

The configuration is broken up into sections to make it easier to manage.

Directories roughly match root elements in **[values.yaml](https://github.com/jenkinsci/helm-charts/blob/main/charts/jenkins/values.yaml)**.

* master - Configuration for Jenkins master
  * jobs
  * tools
* agents - Define all available Jenkins agents
* backup - Cron backup job
* networkPolicy
* persistence
* rbac
* serviceAccount

## Getting Helm chart

```
helm repo add jenkinsci https://charts.jenkins.io
```

## Build the values

```
./generate_config.sh
```

## Stand up the service in Minikube

```
minikube start
kubectl create ns jenkins
helm install -f /tmp/jenkins_values.yaml -n jenkins jenkins jenkinsci/jenkins
./minikube-endpoint.sh # Go to the endpoint
```

## Stand up the service in EKS

Created EKS cluster with `eksctl`

```
eksctl create cluster --name=jenkins --nodes=4 --auto-kubeconfig --region us-east-1
```

### Install Helm Chart

```
helm install --kubeconfig /Users/kjenney/.kube/eksctl/clusters/jenkins -f /tmp/jenkins_values.yaml jenkins jenkinsci/jenkins
```

### Get the Jenkins URL

```
export POD_NAME=$(kubectl --kubeconfig=/Users/kjenney/.kube/eksctl/clusters/jenkins get pods --namespace default -l "app.kubernetes.io/component=jenkins-master" -l "app.kubernetes.io/instance=jenkins" -o jsonpath="{.items[0].metadata.name}")
echo http://127.0.0.1:8080
kubectl --kubeconfig=/Users/kjenney/.kube/eksctl/clusters/jenkins --namespace default port-forward $POD_NAME 8080:8080
```

## Get Pod Logs

```
kubectl logs -n jenkins -c jenkins -l app.kubernetes.io/component=jenkins-master
```
