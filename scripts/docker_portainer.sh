#!/bin/bash

# Description: Install Docker CE on Ubuntu systems

set -e

echo "🐳 Installing Docker CE..."

# Check if Docker is already installed
if command -v docker &> /dev/null; then
    echo "✅ Docker is already installed (version: $(docker --version))"
    echo "⏭️  Skipping Docker installation..."
else
    echo "📥 Docker not found, installing..."
    
    echo "Updating package list..."
    sudo apt update

    echo "Installing required packages..."
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

    echo "Adding Docker's official GPG key..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo "Adding Docker repository..."
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    echo "Updating package list with Docker repository..."
    sudo apt update

    echo "Checking Docker CE policy..."
    apt-cache policy docker-ce

    echo "Installing Docker CE..."
    sudo apt install -y docker-ce

    echo "🔧 Docker CE installed successfully!"
fi

echo "Checking Docker service status..."
sudo systemctl status docker --no-pager || echo "ℹ️  Docker service status check completed (exit code is normal)"

echo "🔍 Checking user permissions..."

# Check if user is already in docker group
if groups | grep -q docker; then
    echo "✅ User is already in docker group"
else
    echo "Adding current user to docker group..."
    sudo usermod -aG docker ${USER}
    echo "ℹ️  User added to docker group (logout/login required for changes to take effect)"
fi

echo "📋 Verifying user groups..."
groups

echo "🎉 Docker installation completed!"

# Install Portainer
echo "🐳 Installing Portainer..."
if sudo docker ps -a --format "table {{.Names}}" | grep -q "^portainer$"; then
    echo "✅ Portainer is already installed"
    echo "⏭️  Skipping Portainer installation..."
else
    echo "📥 Portainer not found, installing..."
    
    echo "Creating Portainer data volume..."
    sudo docker volume create portainer_data
    
    echo "Starting Portainer container..."
    sudo docker run -d -p 8000:8000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
    
    echo "🔧 Portainer installed successfully!"
    echo "ℹ️  Portainer is accessible at: https://localhost:9443"
fi

echo "ℹ️  You may need to log out and log back in for group changes to take effect"
echo "ℹ️  Test Docker with: docker run hello-world"
