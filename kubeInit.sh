set -x

systemctl enable docker.service
kubeadm reset
kubeadm init

export KUBECONFIG=/etc/kubernetes/admin.conf

sysctl net.bridge.bridge-nf-call-iptables=1
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

kubectl get pods --all-namespaces
kubectl taint nodes --all node-role.kubernetes.io/master-

