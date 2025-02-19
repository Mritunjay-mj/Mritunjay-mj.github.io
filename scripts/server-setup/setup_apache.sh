#!/bin/bash

# Script: setup_apache.sh
# Description: Apache2 and SSL setup script for ironfac.me
# Author: Mritunjay-mj
# Date: 2025-02-19

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[✓] $1${NC}"
    else
        echo -e "${RED}[×] $1${NC}"
        exit 1
    fi
}

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Please run as root or with sudo${NC}"
    exit 1
fi

echo "Starting Apache2 and SSL setup for ironfac.me..."

# Update system packages
echo "Updating system packages..."
apt update
apt upgrade -y
print_status "System packages updated"

# Install required packages
echo "Installing Apache2 and SSL tools..."
apt install apache2 openssl ssl-cert certbot python3-certbot-apache -y
print_status "Apache2 and SSL tools installed"

# Enable required Apache modules
echo "Enabling Apache modules..."
a2enmod ssl
a2enmod headers
a2enmod rewrite
print_status "Apache modules enabled"

# Create website directory
echo "Setting up website directory..."
mkdir -p /var/www/ironfac.me
chown -R www-data:www-data /var/www/ironfac.me
chmod -R 755 /var/www/ironfac.me
print_status "Website directory created and permissions set"

# Clone website content
echo "Cloning website content..."
cd /var/www
git clone https://github.com/Mritunjay-mj/Mritunjay-mj.github.io.git ironfac.me
print_status "Website content cloned"

# Install SSL certificate using Let's Encrypt
echo "Installing SSL certificate..."
certbot --apache -d ironfac.me -d www.ironfac.me --non-interactive --agree-tos --email 121ec0003@iiitk.ac.in
print_status "SSL certificate installed"

# Restart Apache2
echo "Restarting Apache2..."
systemctl restart apache2
print_status "Apache2 restarted"

# Verify Apache2 status
echo "Verifying Apache2 status..."
systemctl status apache2 --no-pager
print_status "Apache2 is running"

echo -e "\n${GREEN}Setup completed successfully!${NC}"
echo -e "Please check https://ironfac.me to verify your website"
