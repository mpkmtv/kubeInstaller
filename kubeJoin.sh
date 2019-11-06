set -x

# Kubernetes Installation - Joining a K8S Cluster. To be run only on non-master nodes

systemctl enable docker.service
kubeadm reset

export KUBECONFIG=/etc/kubernetes/admin.conf

sysctl net.bridge.bridge-nf-call-iptables=1

echo "Copy the kubeadm join command from the master node and execute it here"
