kubectl apply --validate=false  -f https://github.com/jetstack/cert-manager/releases/download/v0.15.1/cert-manager.yaml
kubectl apply -n nginx -f - <<EOF
apiVersion: cert-manager.io/v1alpha2
kind: ClusterIssuer
metadata:
  #name: letsencrypt-staging
  name: letsencrypt-prod
spec:
  acme:
    email: olivier@castabnos.pro
    #server: https://acme-staging-v02.api.letsencrypt.org/directory
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: example-issuer-account-key
    solvers:
    - http01:
        ingress: {}
EOF


kubectl apply -n nginx -f - <<EOF
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
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
  tls:
    secretName: $HOST-cert 
    hosts:
    - $HOST
 
EOF
