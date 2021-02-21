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
HOST=nginx.castanos.pro


kubectl apply -n nginx -f - <<EOF
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    # add an annotation indicating the issuer to use
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
  - # cert-manager will store the certificate and key in this secret
    secretName: mysite-cert 
    hosts:
    - $HOST
 
EOF
