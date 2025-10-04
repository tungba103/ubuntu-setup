# Scripts Guide

This folder contains individual installation scripts for various software packages on Ubuntu.

## 📁 Script Structure

Each script follows a consistent structure for reliability and user experience.

### Basic Template

```bash
#!/bin/bash

# Description: Brief description of what this script installs

set -e

echo "🚀 Installing [Package Name]..."

# Check if already installed
if command -v [package] &> /dev/null; then
    echo "✅ [Package] is already installed"
    echo "⏭️  Skipping installation..."
else
    echo "📥 [Package] not found, installing..."
    
    # Installation commands here
    sudo apt update
    sudo apt install -y [package-name]
    
    echo "🔧 [Package] installed successfully!"
fi

echo "✅ [Package Name] installation completed!"
```

## 📋 Required Elements

### 1. Shebang Line
```bash
#!/bin/bash
```

### 2. Description Comment
```bash
# Description: What this script installs
```

### 3. Error Handling
```bash
set -e  # Exit on any error
```

### 4. Installation Check
```bash
if command -v [package] &> /dev/null; then
    echo "✅ Already installed"
else
    echo "📥 Installing..."
fi
```

### 5. User Feedback
- Use emojis for visual clarity
- Provide status updates
- Include helpful information

## 🔧 Script Guidelines

### Do's ✅
- Check if software is already installed
- Use `sudo` only when necessary
- Provide clear feedback messages
- Handle errors gracefully
- Include post-installation notes

### Don'ts ❌
- Don't assume software isn't installed
- Don't run as root (script handles sudo)
- Don't skip error checking
- Don't forget to update package lists

## 🚀 Adding New Scripts

1. Create new `.sh` file in this folder
2. Follow the template structure
3. Test the script thoroughly
4. Make sure it's idempotent (safe to run multiple times)

## 📝 Naming Convention

- Use lowercase with underscores
- Be descriptive: `python_dev.sh`, `firefox.sh`, `nodejs.sh`
- Keep names concise but clear

---

**Note:** Scripts are automatically made executable by the main setup script.
