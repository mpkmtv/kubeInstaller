# Clean-up
clush -a docker system prune --volumes -f

# Remove Docker
clush -a 'yum -y remove docker*'

clush -a rm -Rf /var/lib/docker
clush -a rm -Rf /etc/docker
clush -a sudo rm /etc/yum.repos.d/docker*.repo

# Install Docker
clush -a yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
clush -a yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
clush -a yum install -y docker-ce-18.09*
clush -a systemctl start docker
clush -a docker run hello-world

