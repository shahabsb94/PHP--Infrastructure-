#!/bin/bash

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
sudo dnf install php php-cli php-fpm php-mysqlnd -y

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