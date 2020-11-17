kubeadm reset -f --v=5
rm /etc/cni/net.d -rfv
rm  /etc/kubernetes/manifests/* -rfv
rm .kube/ -rfv
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
swapoff -a
