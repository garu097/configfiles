kubectl delete deployment --all
kubectl delete statefulset --all
kubectl delete daemonset --all
kubectl delete replicaset --all

kubectl delete all --all -A

sudo /usr/local/bin/k3s-uninstall.sh