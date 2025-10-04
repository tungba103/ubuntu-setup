#!/bin/bash

# Description: Install Unikey (Vietnamese input method)

set -e

echo "🇻🇳 Installing Unikey (Vietnamese input method)..."

# Check if Unikey is already installed
if dpkg -l | grep -q "^ii.*ibus-unikey "; then
    echo "✅ Unikey is already installed"
    echo "⏭️  Skipping Unikey installation..."
else
    echo "📥 Unikey not found, installing..."
    
    # Update package list
    sudo apt-get update
    
    # Install Unikey
    sudo apt-get install ibus-unikey -y
    
    echo "🔧 Unikey installed successfully!"
fi

# Restart IBus
echo "🔄 Restarting IBus..."
ibus restart

echo "✅ Unikey installation completed!"
