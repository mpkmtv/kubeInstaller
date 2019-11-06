set -x

# Remove Kubernetes
clush -a yum -y remove kube*

#Install Kubernetes
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

clush -a -c /etc/yum.repos.d/kubernetes.repo /etc/yum.repos.d/kubernetes.repo
clush -a yum install -y kubelet kubeadm kubectl

clush -a systemctl daemon-reload

# Disable SELinux
clush -a setenforce 0
clush -a swapoff -a

# Start kubelet
clush -a systemctl enable kubelet && systemctl start kubelet

# Configure K8S
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
clush -a -c /etc/sysctl.d/k8s.conf /etc/sysctl.d/k8s.conf

clush -a sysctl --system

#  Configure CGroups
clush -a docker info | grep -i cgroup
clush -a cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf | grep -i cgroup
clush -a sed -i "s/cgroup-driver=systemd/cgroup-driver=cgroupfs/g" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

# Restart Kubelet
clush -a systemctl daemon-reload
clush -a systemctl restart kubelet

