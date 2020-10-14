export POD_NAME=$(kubectl --kubeconfig=/Users/kjenney/.kube/eksctl/clusters/jenkins get pods --namespace default -l "app.kubernetes.io/component=jenkins-master" -l "app.kubernetes.io/instance=jenkins" -o jsonpath="{.items[0].metadata.name}")
kubectl --kubeconfig=/Users/kjenney/.kube/eksctl/clusters/jenkins --namespace default port-forward $POD_NAME 8080:8080
JENKINS_URL="http://127.0.0.1:8080"
echo "Go here for Jenkins: $JENKINS_URL"
