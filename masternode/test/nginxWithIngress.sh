kubectl create deployment nginx --image nginx:alpine
kubectl expose deployment nginx --port=80
HOST=nginx.192.168.1.1.nip.io
kubectl create -f - <<EOF
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