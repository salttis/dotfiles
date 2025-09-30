# Dotfiles

A minimal macOS setup with essential tools and configurations.

## Quick Start

```sh
git clone https://github.com/salttis/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

## What it does

This script sets up a minimal but complete development environment:

1. **Install Xcode Command Line Tools**

   - Developer tools and compilers

2. **Install Homebrew**

   - Package manager for macOS
   - Handles both Intel and Apple Silicon Macs

3. **Install Essential Packages**

   - CLI tools: `bat`, `eza`, `git`, `nvm`, `tree`, `jq`, `ffmpeg`
   - Fonts: Commit Mono, Hack, and Sauce Code Pro Nerd Fonts

4. **Setup Node.js Development**

   - Install Node.js LTS via NVM
   - Install essential packages: `eslint`, `prettier`, `typescript`

5. **Configure Shell**

   - Symlink zsh configuration files (`.zshrc`, `.zshenv`, `.p10k.zsh`)

6. **Configure Git**

   - Symlink git configuration (`.gitconfig`)

7. **Setup SSH Keys**

   - Create SSH directory with proper permissions
   - Sync SSH keys from iCloud Drive if available

8. **Configure macOS**
   - Show file extensions in Finder
   - Disable window animations for better performance
   - Enable function keys as standard function keys
   - Show battery percentage in menu bar

## Features

- **Minimal**: Only essential tools and configurations
- **Idempotent**: Safe to run multiple times
- **Self-contained**: No external dependencies
- **Fast**: Streamlined installation process
