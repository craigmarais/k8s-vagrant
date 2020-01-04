#!/usr/bin/env bash

#----------------------------------------------------
# Scripts does below
# - Configures Ingress using Traefik
#----------------------------------------------------
# Author: Ansil H (ansilh@gmail.com)
# Date:   12/28/2018
#----------------------------------------------------
source libs.sh
# Apply RBAC rules for traefik
wget -q https://raw.githubusercontent.com/containous/traefik/v1.7/examples/k8s/traefik-rbac.yaml
adjust_spec_version traefik-rbac.yaml
kubectl apply -f traefik-rbac.yaml

# Download deployment yaml and change service IP type to LoadBalancer
wget -q https://raw.githubusercontent.com/containous/traefik/v1.7/examples/k8s/traefik-deployment.yaml
sed -i 's/type: NodePort/type: LoadBalancer/' traefik-deployment.yaml
adjust_spec_version traefik-deployment.yaml
kubectl apply -f traefik-deployment.yaml

# Download Traefik UI yaml and change the virtual hostname from default to traefik-ui.linxlabs.local 
wget -q https://raw.githubusercontent.com/containous/traefik/v1.7/examples/k8s/ui.yaml
adjust_spec_version ui.yaml
sed -i 's/traefik-ui.minikube/traefik-ui.linxlabs.local/' ui.yaml
kubectl apply -f ui.yaml
