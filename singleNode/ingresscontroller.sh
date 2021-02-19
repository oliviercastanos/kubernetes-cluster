kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl apply -f https://raw.githubusercontent.com/oliviercastanos/kubernetes-cluster/master/singleNode/haproxy-ingress.yaml
kubectl label node $(hostname) role=ingress-controller