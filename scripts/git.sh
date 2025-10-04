#!/bin/bash

# Description: Install Git and essential development tools

set -e

echo "📦 Installing Git and essential development tools..."

# Check if Git is already installed
if command -v git &> /dev/null; then
    echo "✅ Git is already installed (version: $(git --version))"
    echo "⏭️  Skipping Git installation..."
else
    echo "📥 Git not found, installing..."
    
    # Update package list
    sudo apt update
    
    # Install Git and essential tools
    sudo apt install -y \
        git \
        curl \
        wget \
        build-essential \
        unzip \
        software-properties-common \
        apt-transport-https \
        ca-certificates \
        gnupg \
        lsb-release \
        vim \
        nano \
        htop \
        tree
fi

# Configure Git with basic settings (user will need to set their own email/name)
echo "🔧 Git setup completed!"
echo "ℹ️  Don't forget to configure Git with your credentials:"
echo "   git config --global user.name 'Your Name'"
echo "   git config --global user.email 'your.email@example.com'"

echo "✅ Git and essential tools installation completed!"
