kubectl create -f https://haproxy-ingress.github.io/resources/haproxy-ingress.yaml
kubectl label node node1 role=ingress-controller