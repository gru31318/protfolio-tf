#!/bin/bash
NAMESPACE="argocd"
if [ "$1" == "--install" ]; then
    #namespce 
    if kubectl get namespace "$NAMESPACE" &> /dev/null; then
    echo "Namespace '$NAMESPACE' already exists. Skipping..."
    else
    kubectl create namespace "$NAMESPACE"
    fi
    # ingres nginx
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx 
    helm install nginx ingress-nginx/ingress-nginx --namespace $NAMESPACE  
    # argo 
    sleep 2
    helm repo add argo https://argoproj.github.io/argo-helm
    helm install argocd argo/argo-cd -f argo-values.yaml --namespace $NAMESPACE 

    while true; do
    ingress_status=$(kubectl get service -n $NAMESPACE nginx-ingress-nginx-controller -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
        
    if [ -z "$ingress_status" ]; then
            echo "ingress ngnix is still pending..."
            sleep 5  
    else
            echo "External IP of the service: $ingress_status"
            break  
    fi
    done
    echo "run: sudo sed -i \"/argocd\.me/c $ingress_status argocd.me\" /etc/hosts"
    echo "and go to: http://argocd.me"
    echo "username: admin"
    echo "password: argopass"
elif [ "$1" == "--delete" ]; then
    echo "deleting.."
    helm delete nginx --namespace $NAMESPACE
    helm delete argocd --namespace $NAMESPACE
else
    echo -e "run ./argo.sh --install to install \nor if you need, --delete to delete it"
fi