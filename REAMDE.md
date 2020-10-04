# jenkins-helm-separated-configs

## Requirements

* Helm (`brew install helm`)
* Python 3 (`brew install python@3.8`)

## Configuration

The configuration is broken up into sections to make it easier to manage.

Directions roughly match root elements in **[values.yaml](https://github.com/jenkinsci/helm-charts/blob/main/charts/jenkins/values.yaml)**.

* master - Configuration for Jenkins master
  * jobs - Definitions for jobs
* agents - Define all available Jenkins agents
* backup - Cron backup job
* networkPolicy
* persistence
* rbac
* serviceAccount

** Figure out how to get secret password values in configuration **

### Generating Configuration

```
./generate_config.py
```

## Standing up Jenkins

Getting Jenkins up and running after you've generated the complete values.yaml for the Helm chart.

### Create EKS Cluster

Created EKS cluster with `eksctl`

```
eksctl create cluster --name=jenkins --nodes=4 --auto-kubeconfig --region us-east-1
```

### Install Helm Chart

```
helm3 install --kubeconfig /Users/kjenney/.kube/eksctl/clusters/jenkins -f /tmp/jenkins_values.yaml jenkins jenkinsci/jenkins
```

### Login to Jenkins

#### Get Admin Password

```
kubectl --kubeconfig=/Users/kjenney/.kube/eksctl/clusters/jenkins get secret --namespace default jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode
```

#### Get the Jenkins URL

```
export POD_NAME=$(kubectl --kubeconfig=/Users/kjenney/.kube/eksctl/clusters/jenkins get pods --namespace default -l "app.kubernetes.io/component=jenkins-master" -l "app.kubernetes.io/instance=jenkins" -o jsonpath="{.items[0].metadata.name}")
echo http://127.0.0.1:8080
kubectl --kubeconfig=/Users/kjenney/.kube/eksctl/clusters/jenkins --namespace default port-forward $POD_NAME 8080:8080
```
