kubectl create namespace nginx
kubectl create deployment nginx --image nginx:alpine -n nginx
kubectl expose deployment nginx --port=80 -n nginx
HOST=nginx.castanos.pro
kubectl create -n nginx -f - <<EOF
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: nginx
spec:
  rules:
  - host: $HOST
    http:
      paths:
      - backend:
          serviceName: nginx
          servicePort: 80
        path: /
EOF