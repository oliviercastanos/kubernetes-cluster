
kubectl create namespace nginx
kubectl create deployment nginx --image nginx:alpine -n nginx
kubectl expose deployment nginx --port=8080 --target-port=80  -n nginx
HOST=nginx.castanos.pro
kubectl apply -n nginx -f - <<EOF
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
 name: nginx
 namespace: nginx
spec:
 rules:
 - host: $HOST
   http:
     paths:
     - path: /
       backend:
         serviceName: nginx
         servicePort: 8080

 
EOF
