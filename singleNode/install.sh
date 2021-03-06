systemctl stop firewalld && systemctl disable firewalld
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum remove runc podman docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine -y
curl https://download.docker.com/linux/centos/docker-ce.repo > /etc/yum.repos.d/docker.repo
yum install docker-ce docker-ce-cli containerd.io -y
systemctl enable docker &&  systemctl start docker
yum install -y  kubeadm
systemctl enable kubelet && systemctl start kubelet
swapoff -a
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

kubeadm init  --v=5
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

