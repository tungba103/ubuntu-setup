#!/bin/bash

# Description: Install Visual Studio Code

set -e

echo "📝 Installing Visual Studio Code..."

# Check if VS Code is already installed
if command -v code &> /dev/null; then
    echo "✅ VS Code is already installed (version: $(code --version | head -1))"
    echo "⏭️  Skipping VS Code installation..."
else
    echo "📥 VS Code not found, installing..."
    
    # Update package list
    sudo apt update
    
    # Install prerequisites
    sudo apt install -y \
        wget \
        gpg \
        software-properties-common
    
    # Check if Microsoft repository is already added
    if [ ! -f "/etc/apt/sources.list.d/vscode.list" ]; then
        echo "📦 Adding Microsoft repository..."
        
        # Add Microsoft GPG key
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
        sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
        
        # Clean up GPG file
        rm -f packages.microsoft.gpg
        
        # Update package list
        sudo apt update
    else
        echo "✅ Microsoft repository already added"
    fi
    
    # Install VS Code
    sudo apt install -y code
    
    echo "🔧 VS Code installed successfully!"
    echo "ℹ️  You can launch VS Code from the applications menu or by running 'code' in the terminal"
    echo "ℹ️  VS Code will automatically update through the package manager"
fi

echo "✅ Visual Studio Code installation completed!"
