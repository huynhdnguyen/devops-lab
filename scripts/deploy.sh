#!/bin/bash

set -x


# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "kubectl is not installed. Please install kubectl and try again."
    exit 1
fi

# Check if connected to Kubernetes cluster
if ! kubectl cluster-info &> /dev/null; then
    echo "Not connected to a Kubernetes cluster. Please connect to a cluster and try again."
    exit 1
fi


kubectl config use-context minikube

# # Load configuration to ENV
# require yq version >= 4.44.3 

export $(yq e -o=s '.' config.yaml| sed "s/'//g") 


# Create namespace if it doesn't exist
kubectl create namespace $kubernetes_namespace_cicd
kubectl create namespace $kubernetes_namespace_database
kubectl create namespace $kubernetes_namespace_log

# Deploy DB
kubectl run mongodb --image=mongo --port=$database_port
kubectl expose pod mongodb --type=ClusterIP --name=mongodb --port=$database_port --target-port=$database_port

#Deploy jenkins
helm repo add jenkins https://charts.jenkins.io
helm install jenkins jenkins/jenkins -f kubernetes/jenkins/values.yaml
#kubectl create configmap jenkins-casc-config --from-file=kubernetes/jenkins-casc-config.yaml

# Deploy App
helm install $appName kubernetes/$appName  -f config.yaml
# echo "Applying Kubernetes manifests..."
# kubectl apply -f kubernetes/ -n ${kubernetes_namespace}

# # Wait for deployments to be ready
# echo "Waiting for deployments to be ready..."
# kubectl wait --for=condition=available --timeout=300s deployment/${app_name}-frontend -n ${kubernetes_namespace}
# kubectl wait --for=condition=available --timeout=300s deployment/${app_name}-backend -n ${kubernetes_namespace}

# # Get ingress URL
# ingress_url=$(kubectl get ingress ${app_name}-ingress -n ${kubernetes_namespace} -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "Deployment completed successfully!"
echo "You can access the application at: http://${ingress_url}"


