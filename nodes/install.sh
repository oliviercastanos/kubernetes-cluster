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
yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine -y
curl https://download.docker.com/linux/centos/docker-ce.repo > /etc/yum.repos.d/docker.repo
yum install docker-ce docker-ce-cli containerd.io -y
systemctl enable docker &&  systemctl start docker
yum install kubeadm -y
swapoff -a

systemctl enable kubelet && systemctl start kubelet
echo "copy paste kubectl join command from masternode"