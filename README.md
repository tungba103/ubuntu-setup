# 🚀 Ubuntu Development Environment Setup Scripts

[![Ubuntu](https://img.shields.io/badge/Ubuntu-18.04%2B-orange?style=flat-square&logo=ubuntu)](https://ubuntu.com/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/tungba103/ubuntu-setup.svg?style=flat-square)](https://github.com/tungba103/ubuntu-setup/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/tungba103/ubuntu-setup.svg?style=flat-square)](https://github.com/tungba103/ubuntu-setup/network)

> **Automated Ubuntu Development Setup** - One-click installation of essential development tools including Docker, VS Code, Git, Node.js, and more for Ubuntu Linux systems.

A comprehensive collection of bash **scripts** for automated installation and configuration of development tools and applications on Ubuntu Linux systems. This **Ubuntu Development Environment Setup** solution provides everything you need to create a complete **development environment** on your Ubuntu workstation. Perfect for developers, system administrators, and anyone looking to quickly set up a productive development environment.

## 🎯 Perfect For
- **Web Developers** setting up Node.js, Docker, and VS Code
- **DevOps Engineers** configuring containerization with Docker and Portainer
- **System Administrators** automating Ubuntu development environment setup
- **Students and Beginners** learning Ubuntu development tool installation
- **Teams** standardizing development environments across Ubuntu workstations

## 🔍 Keywords 
`Ubuntu setup`, `development environment`, `Docker installation`, `VS Code Ubuntu`, `Node.js setup`, `Git configuration`, `automated installation`, `bash scripts`, `Linux development`, `Ubuntu tools`, `development setup`, `Ubuntu 22.04`, `Ubuntu 24.04`

## 📋 Table of Contents

- [🎯 Perfect For](#-perfect-for)
- [🔍 Keywords](#-keywords)
- [🚀 Quick Start](#-quick-start)
- [🛠️ Development Tools](#️-development-tools-included)
- [📦 Installation Options](#-individual-script-installation)
- [📋 Prerequisites](#-prerequisites)
- [✨ Key Features](#-key-features)
- [🔧 Troubleshooting](#-troubleshooting)
- [🤝 Contributing](#-contributing)

## 🚀 Quick Start

Get your **Ubuntu Development Environment** up and running with these automated **setup scripts** in 3 simple steps:

```bash
# 1. Clone and navigate to the repository
git clone https://github.com/tungba103/ubuntu-setup.git
cd ubuntu-setup

# 2. Make scripts executable
chmod +x setup.sh

# 3. Run the automated setup
./setup.sh
```

**That's it!** The automated **setup scripts** will install and configure your complete **Ubuntu Development Environment** with all essential tools.

## 🛠️ Development Tools Included

This **Ubuntu Development Environment Setup** repository contains automated installation **scripts** for essential development tools:

| Tool | Description | Category |
|------|-------------|----------|
| 🎯 **Cursor AI** | AI-powered code editor with intelligent assistance | Code Editor |
| 🐳 **Docker & Portainer** | Containerization platform with intuitive web UI | DevOps |
| 📝 **Git** | Distributed version control system | Version Control |
| 📦 **NVM (Node Version Manager)** | Node.js version management and installation | Runtime |
| 🇻🇳 **UniKey** | Vietnamese input method for Ubuntu Linux | Localization |
| 💻 **VS Code** | Popular Microsoft Visual Studio Code editor | Code Editor |

### Why Choose This Ubuntu Development Environment Setup?

- **🔥 One-Click Installation** - Automated **setup scripts** eliminate manual configuration
- **🛡️ Production-Ready** - Tested on Ubuntu 18.04+ systems for reliable **development environment** setup
- **📈 Developer-Focused** - Curated selection of essential development tools for your **Ubuntu Development Environment**
- **🚀 Time-Saving** - Set up your entire **development environment** with automated **scripts** in minutes

## 📦 Installation Options

Run specific installation **scripts** for targeted **Ubuntu Development Environment** setup:

```bash
# Install Cursor AI
./scripts/cursor.sh

# Install Docker and Portainer
./scripts/docker_portainer.sh

# Install Git
./scripts/git.sh

# Install NVM
./scripts/nvm.sh

# Install UniKey
./scripts/unikey.sh

# Install VS Code
./scripts/vscode.sh
```

## 📋 Prerequisites

Before running the **Ubuntu Development Environment Setup scripts**, ensure your system meets these requirements:

- ✅ **Ubuntu 18.04 LTS or later** (tested on Ubuntu 20.04, 22.04, 24.04)
- ✅ **Active internet connection** for downloading packages and repositories
- ✅ **Administrative privileges** (`sudo` access - scripts will prompt when needed)
- ✅ **At least 2GB free disk space** for development tools and dependencies

### System Compatibility

| Ubuntu Version | Status | Notes |
|----------------|--------|-------|
| Ubuntu 18.04 LTS | ✅ Supported | Legacy support |
| Ubuntu 20.04 LTS | ✅ Fully Supported | Recommended |
| Ubuntu 22.04 LTS | ✅ Fully Supported | Latest LTS |
| Ubuntu 24.04 LTS | ✅ Fully Supported | Latest release |

## ✨ Key Features

Our **Ubuntu Development Environment Setup scripts** provide comprehensive automation for your **development environment**:

| Feature | Description | Benefit |
|---------|-------------|---------|
| 🤖 **Automated Installation** | Zero-touch installation process | Saves hours of manual configuration |
| 📌 **Version Management** | Specific version pinning for stability | Ensures consistent development environments |
| 🔗 **Dependency Handling** | Automatic dependency resolution | No missing package issues |
| 🛡️ **Error Handling** | Comprehensive error management | Clear troubleshooting guidance |
| ⚡ **Smart Skip Logic** | Detects existing installations | Prevents conflicts and saves time |
| 🧹 **Auto Cleanup** | Temporary file removal | Keeps system clean and organized |
| 📊 **Progress Tracking** | Real-time installation feedback | Transparent process monitoring |
| 🔒 **Security Focus** | Verified package sources | Safe and secure installations |

## 🔧 Troubleshooting

### Common Issues and Solutions

#### 🔐 Permission Issues
If you encounter permission errors, ensure scripts have proper execute permissions:
```bash
chmod +x setup.sh scripts/*.sh
```

#### 🌐 Network Connectivity Issues
- **Check internet connection** - Verify stable internet access
- **Corporate firewall** - Ensure ports 80, 443, and 22 are accessible
- **Proxy settings** - Configure system proxy if behind corporate firewall

#### 🔑 GPG Key Verification Warnings
GPG key prompts are normal for third-party packages:
- **Docker** - Accept the official Docker GPG key when prompted
- **VS Code** - Accept Microsoft's GPG key for the repository
- **Node.js** - Accept NodeSource GPG keys for Node.js packages

#### 🐳 Docker Installation Issues
If Docker fails to install:
```bash
# Remove existing Docker packages
sudo apt-get remove docker docker-engine docker.io containerd runc

# Re-run Docker installation
./scripts/docker_portainer.sh
```

#### 📦 Package Manager Conflicts
If you encounter package conflicts:
```bash
# Update package lists
sudo apt update && sudo apt upgrade -y

# Fix broken dependencies
sudo apt --fix-broken install
```

## 🤝 Contributing

We welcome contributions to improve this **Ubuntu Development Environment Setup**! Here's how you can help enhance our **setup scripts**:

**🐛 Bug Reports**: Use the [Issues](https://github.com/tungba103/ubuntu-setup/issues) tab to report bugs. Include Ubuntu version, error messages, and steps to reproduce.

**💡 Feature Requests**: Suggest new development tools or improvements to existing **setup scripts** for the **Ubuntu Development Environment**.

**🔧 Pull Requests**: 
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

**📝 Documentation**: Improve README sections, add installation guides for additional tools in our **Ubuntu Development Environment Setup**, or create video tutorials.

---

<div align="center">

**⭐ Star this repository if you found it helpful!**

[![GitHub stars](https://img.shields.io/github/stars/tungba103/ubuntu-setup.svg?style=social&label=Star)](https://github.com/tungba103/ubuntu-setup)
[![GitHub forks](https://img.shields.io/github/forks/tungba103/ubuntu-setup.svg?style=social&label=Fork)](https://github.com/tungba103/ubuntu-setup/fork)

Made with ❤️ for the Ubuntu development community

</div>
