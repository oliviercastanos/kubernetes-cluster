README.md
# Pour installer un cluster Kubernetes avec kubeadm sur CentOS 7

## sur le noeud maître lancer:
- init.sh
- install.sh

Bien sauvegarder la commande contenant le token qui sera affichée et qui permettra aux noeuds de rejoindre le cluster

## sur le noeud worker lancer:
- init.sh
- install.sh
- copier la commande contenant le token

## pour déployer les ingresscontrollers

- sur le noeud maître lancer ingresscontroller.sh

## pour tester
- lancer nginxWithIngress.sh
- dans le fichier hosts de l'ordinateur ajouter : IP_D_UN_NOEUD nginx.192.168.1.1.nip.io
- dans le navigateur se rendre sur nginx.192.168.1.1.nip.io
