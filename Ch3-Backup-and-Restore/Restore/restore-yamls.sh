#!/bin/bash
echo "Restoring..."
# re-genereate default secret
kubectl get secret -n kube-system -o wide | grep "\-token-" | awk '{system("kubectl delete secret "$1 " -n kube-system")}'
kubectl get secret -n services -o wide | grep "\-token-" | awk '{system("kubectl delete secret "$1 " -n services")}'
kubectl get secret -n istio-system -o wide | grep "\-token-"| awk '{system("kubectl delete secret "$1 " -n istio-system")}'
kubectl get secret -n kube-public -o wide | grep "\-token-"| awk '{system("kubectl delete secret "$1 " -n kube-public")}'
kubectl get secret -n ibmcom -o wide | grep "\-token-"| awk '{system("kubectl delete secret "$1 " -n ibmcom")}'
kubectl get secret -n cert-manager -o wide | grep "\-token-"| awk '{system("kubectl delete secret "$1 " -n cert-manager")}'

namespaces=(kube-system services istio-system kube-public ibmcom cert-manager)

for ns in ${namespaces[@]}
do
    #secret
    for s in $(ls $ns.secret/ | grep -v "\-token-")
    do
        kubectl delete -f $ns.secret/$s && kubectl create -f $ns.secret/$s
    done

    #configmap
    for s in $(ls $ns.configmap/)
    do
        kubectl delete -f $ns.configmap/$s && kubectl create -f $ns.configmap/$s
    done
done

kubectl --force --grace-period=0 delete pv $(kubectl get pv | grep -e "image-manager-" -e "icp-mongodb-" -e "mariadb-" -e "logging-datanode-" -e "kafka-" -e "zookeeper-" -e "minio-"  | awk '{print $1}')

kubectl patch pv $(kubectl get pv | grep Terminating | awk '{print $1}') -p '{"metadata":{"finalizers":null}}'

kubectl delete pvc -n kube-system $(kubectl get pvc -n kube-system | grep -e "image-manager-image-manager-" -e "mongodbdir-icp-mongodb-" -e "mysqldata-mariadb-" -e "data-logging-elk-data-" -e "-vulnerability-advisor-" -e "datadir-vulnerability-advisor-kafka-" -e "datadir-vulnerability-advisor-zookeeper-" -e "datadir-vulnerability-advisor-minio-" | awk '{print $1}')


echo "Done."