#!/bin/bash
echo "Restoring..."
# Apply the deployments and daemonsets as image names are in these files
namespaces=(kube-system services istio-system kube-public ibmcom cert-manager)

for ns in ${namespaces[@]}
do

    for s in $(ls $ns.deployment.extensions/)
    do
        kubectl delete -f $ns.deployment.extensions/$s && kubectl create -f $ns.deployment.extensions/$s
    done
    
    for s in $(ls $ns.daemonset.extensions/)
    do
        kubectl delete -f $ns.daemonset.extensions/$s && kubectl create -f $ns.daemonset.extensions/$s
    done
    
done

echo "Done."