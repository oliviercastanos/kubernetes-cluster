kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl create namespace ingress-controller
helm repo add haproxytech https://haproxytech.github.io/helm-charts
helm repo update
helm install haproxy haproxytech/kubernetes-ingress --set controller.kind=DaemonSet --set controller.daemonset.useHostPort=true  -n ingress-controller


helm upgrade --install haproxy haproxytech/kubernetes-ingress --set controller.kind=DaemonSet --set controller.daemonset.useHostPort=true --set-string "controller.config.forwarded-for=true" -n ingress-controller
