#!/bin/bash

# Set files
files=(
servicecatalog.yaml
daemonset.extensions/service-catalog-apiserver.yaml
daemonset.extensions/auth-idp.yaml
daemonset.extensions/calico-node.yaml
daemonset.extensions/nginx-ingress-controller.yaml
daemonset.extensions/icp-management-ingress.yaml
deployment.extensions/helm-api.yaml
deployment.extensions/helm-repo.yaml
deployment.extensions/metering-ui.yaml
deployment.extensions/metering-dm.yaml
deployment.extensions/monitoring-prometheus-alertmanager.yaml
deployment.extensions/monitoring-prometheus.yaml
)

# Delete and recreate resources
for f in ${files[@]}
do
    kubectl delete -f kube-system.$f && kubectl create -f kube-system.$f
done