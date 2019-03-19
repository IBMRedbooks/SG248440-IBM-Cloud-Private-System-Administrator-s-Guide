#!/bin/bash
namespaces=(kube-system kube-public services istio-system ibmcom cert-manager)
echo "Saving all ConfigMaps, Secrets, Deployments and Daemonsets..."
for ns in ${namespaces[@]}
do
    mkdir $ns.configmap $ns.secret $ns.deployment.extensions $ns.daemonset.extensions
    # save configmap, secret, deployment, daemonset
    for n in $(kubectl get -o=name configmap,secret,ds,deployment -n $ns)
    do
        kubectl get -o yaml -n $ns $n > $ns.$n.yaml
    done
done

kubectl get APIService -n kube-system -o yaml v1beta1.servicecatalog.k8s.io > kube-system.servicecatalog.yaml

echo "Done."