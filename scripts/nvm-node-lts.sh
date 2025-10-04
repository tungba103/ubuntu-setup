#!/bin/bash

# Description: Install Node Version Manager (nvm) and latest LTS Node.js

set -e

echo "📦 Installing Node Version Manager (nvm)..."

# Check if nvm is already installed
if command -v nvm &> /dev/null || [ -d "$HOME/.nvm" ]; then
    echo "✅ nvm is already installed"
    echo "⏭️  Skipping nvm installation..."
else
    echo "📥 nvm not found, installing..."
    
    # Update package list
    sudo apt-get update
    
    # Install curl if not available
    if ! command -v curl &> /dev/null; then
        echo "📦 Installing curl..."
        sudo apt install -y curl
    fi
    
    echo "⬇️  Downloading and installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    
    # Source nvm to make it available in current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    echo "🔧 nvm installed successfully!"
fi

# Verify nvm installation and install Node.js LTS
echo "🔍 Verifying nvm installation..."
if command -v nvm &> /dev/null || [ -s "$HOME/.nvm/nvm.sh" ]; then
    # Source nvm if not already sourced
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    echo "📋 nvm version: $(nvm --version)"
    
    echo "⬇️  Installing latest LTS Node.js..."
    nvm install --lts
    
    echo "🔧 Node.js LTS installed successfully!"
    echo "📋 Node.js version: $(node --version)"
    echo "📋 npm version: $(npm --version)"
else
    echo "❌ nvm installation verification failed"
    echo "ℹ️  You may need to restart your terminal or run: source ~/.bashrc"
fi

echo "✅ nvm installation completed!"
echo "ℹ️  You can now use nvm commands to manage Node.js versions"
echo "ℹ️  Common commands:"
echo "   nvm list                    # List installed Node.js versions"
echo "   nvm install 18.17.0        # Install specific Node.js version"
echo "   nvm use 18.17.0            # Switch to specific Node.js version"
echo "   nvm alias default 18.17.0  # Set default Node.js version"
echo "ℹ️  If nvm commands don't work, restart your terminal or run: source ~/.bashrc"
