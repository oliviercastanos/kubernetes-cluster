kubectl create namespace nginx
kubectl create deployment nginx --image nginx:alpine -n nginx
kubectl expose deployment nginx --port=80 -n nginx
HOST=nginx.castanos.pro
kubectl create -n nginx -f - <<EOF
kind: Ingress
apiVersion: networking.k8s.io/v1
metadata:
  name: nginx
  namespace: nginx
  annotations:
    kubernetes.io/ingress.class: haproxy
spec:
  rules:
    - host: nginx.castanos.pro
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: nginx
                port:
                  number: 80
EOF
