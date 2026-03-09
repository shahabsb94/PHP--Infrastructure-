#!/bin/bash

#resize disk from 20GB to 50GB
growpart /dev/nvme0n1 4

lvextend -L +10G /dev/RootVG/rootVol
lvextend -L +10G /dev/mapper/RootVG-varVol
lvextend -l +100%FREE /dev/mapper/RootVG-varTmpVol

xfs_growfs /
xfs_growfs /var/tmp
xfs_growfs /var

# Update server
sudo yum update -y

# Install Apache Web Server
sudo yum install httpd -y

# Enable Apache on boot
sudo systemctl enable httpd

# Start Apache
sudo systemctl start httpd

# Check Apache status
sudo systemctl status httpd

# Install PHP
sudo yum install php php-mysqlnd php-fpm php-json php-cli -y 
# OR 
# sudo dnf install php php-cli php-fpm php-mysqlnd -y

# Install git
sudo yum install git -y

# Go to Apache root directory
cd /var/www/html

# Clone PHP application from GitHub
sudo git clone https://github.com/shahabsb94/PHP-Application.git

# Move application files to web root
sudo mv PHP-Application/* .

# Remove cloned folder
sudo rm -rf PHP-Application

# Set correct permissions
sudo chown -R apache:apache /var/www/html

# Restart Apache
sudo systemctl restart httpd

# Install Docker
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# install java & Jenkins

curl -fsSL https://pkg.jenkins.io/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo dnf install -y java-17-openjdk fontconfig

sudo dnf clean all
sudo dnf makecache

sudo dnf install -y jenkins

sudo systemctl daemon-reexec
sudo systemctl enable jenkins
sudo systemctl start jenkins

sudo systemctl status jenkins


# sudo dnf install nano -y
# sudo nano /usr/lib/systemd/system/jenkins.service ---> if we want to change Jenkins port form 8080 -8081
# change Environment="JENKINS_PORT=8081"

# cat /var/lib/jenkins/secrets/initialAdminPassword


## Install kubectl on EC2 (Jenkins Server)

# Download kubectl from the official Kubernetes release
curl -LO https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl

# Make it executable
chmod +x kubectl

# Move it to system path
sudo mv kubectl /usr/local/bin/

# Verify installation
kubectl version --client

# Step 1 — Install Minikube
# curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# sudo install minikube-linux-amd64 /usr/local/bin/minikube

# minikube version

