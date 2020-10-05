MINIKUBE_IP=$(minikube ip)
NODEPORT=$(kubectl -n jenkins get svc jenkins | tail -n 1 | awk -F ':' '{print $2}' | awk -F '/' '{print $1}')
JENKINS_URL="http://$MINIKUBE_IP:$NODEPORT"
echo "Go here for Jenkins: $JENKINS_URL"
