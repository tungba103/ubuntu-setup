#!/bin/bash

# Description: Install Cursor AI code editor

set -e

echo "📝 Installing Cursor AI code editor..."

# Version configuration
CURSOR_VERSION="1.7"
DOWNLOAD_URL="https://api2.cursor.sh/updates/download/golden/linux-x64-deb/cursor/${CURSOR_VERSION}"
TMP_DEB="/tmp/cursor-${CURSOR_VERSION}.deb"

# Check if Cursor is already installed
if command -v cursor &> /dev/null; then
    echo "✅ Cursor is already installed (version: $(cursor --version 2>/dev/null || echo 'unknown'))"
    echo "⏭️  Skipping Cursor installation..."
else
    echo "📥 Cursor not found, installing..."
    
    # Check if wget is available
    if ! command -v wget &> /dev/null; then
        echo "📦 Installing wget..."
        sudo apt update
        sudo apt install -y wget
    fi
    
    echo "⬇️  Downloading Cursor v${CURSOR_VERSION}..."
    if ! wget -q -O "${TMP_DEB}" "${DOWNLOAD_URL}"; then
        echo "❌ Failed to download from ${DOWNLOAD_URL}"
        echo "ℹ️  Please check your internet connection and try again"
        exit 1
    fi
    
    echo "📦 Installing Cursor via dpkg..."
    sudo DEBIAN_FRONTEND=noninteractive dpkg -i "${TMP_DEB}" || sudo DEBIAN_FRONTEND=noninteractive apt-get install -f -y --assume-yes
    
    echo "🧹 Cleaning up temporary files..."
    rm -f "${TMP_DEB}"
    
    echo "🔧 Cursor installed successfully!"
fi

echo "✅ Cursor installation completed!"
echo "ℹ️  You can launch Cursor from the applications menu or by running 'cursor' in the terminal"
echo "ℹ️  To update later: Download and install the latest .deb package from cursor.sh"
