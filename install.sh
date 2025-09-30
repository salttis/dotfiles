#!/usr/bin/env bash

set -e

export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES="${DOTFILES:-$SCRIPT_DIR}"

# =============================================================================
# Minimal Dotfiles Installation Script
# =============================================================================

# 1. Install Xcode Command Line Tools
install_xcode_tools() {
    if ! xcode-select -p &>/dev/null; then
        echo "Installing Xcode Command Line Tools..."
        xcode-select --install
        echo "Press any key when installation completes..."
        read -nr 1
        sudo xcodebuild -license accept
    else
        echo "Xcode Command Line Tools already installed"
    fi
}

# 2. Install Homebrew
install_homebrew() {
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        echo "Homebrew already installed"
    fi
}

# 3. Install packages from minimal Brewfile
install_homebrew_packages() {
    echo "Installing essential Homebrew packages..."
    brew bundle install --file="$DOTFILES/Brewfile"
}

# 4. Install Node and NPM via NVM
install_node_via_nvm() {
    echo "Setting up Node.js via NVM..."
    
    # Load NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
    
    if command -v nvm &>/dev/null; then
        echo "Installing latest Node.js LTS..."
        if nvm install --lts; then
            nvm use --lts
        else
            echo "Error: Failed to install Node.js LTS via nvm." >&2
            exit 1
        fi
    fi
}

# 5. Install minimal NPM packages
install_npm_packages() {
    echo "Installing essential NPM packages..."
    
    if ! npm install -g eslint prettier typescript; then
        echo "Error: Failed to install essential NPM packages." >&2
        exit 1
    fi
}

# 6. Configure zsh (symlink zshenv and zshrc)
configure_zsh() {
    echo "Configuring zsh..."
    
    # Symlink zsh configuration files
    if [[ -f "$DOTFILES/.zshenv" ]]; then
        ln -sf "$DOTFILES/.zshenv" "$HOME/.zshenv"
    fi
    
    if [[ -f "$DOTFILES/.zshrc" ]]; then
        ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"
    fi

    if [[ -f "$DOTFILES/.p10k.zsh" ]]; then
        ln -sf "$DOTFILES/.p10k.zsh" "$HOME/.p10k.zsh"
    fi
}

# 7. Configure git (symlink gitconfig)
configure_git() {
    echo "Configuring git..."

    # Symlink gitignore
    if [[ -f "$DOTFILES/.gitignore" ]]; then
        ln -sf "$DOTFILES/.gitignore" "$HOME/.gitignore"
    fi

    # Symlink gitconfig
    if [[ -f "$DOTFILES/.gitconfig" ]]; then
        ln -sf "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
    fi
}

# 8. Set up SSH keys
setup_ssh_keys() {
    echo "Setting up SSH keys..."
    
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    
    # Sync SSH files from iCloud if available
    local icloud_ssh="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Workspace/ssh"
    if [[ -d "$icloud_ssh" ]]; then
        # Explicitly symlink known SSH key files and config files
        for keyfile in id_rsa id_rsa.pub id_ed25519 id_ed25519.pub config known_hosts; do
            if [[ -f "$icloud_ssh/$keyfile" ]]; then
                ln -sf "$icloud_ssh/$keyfile" "$HOME/.ssh/$keyfile"
            fi
        done
        # Set permissions: private keys 600, public keys 644, config/known_hosts 644
        find "$HOME/.ssh" -type f -name "id_*" ! -name "*.pub" -exec chmod 600 {} \; 2>/dev/null || true
        find "$HOME/.ssh" -type f -name "*.pub" -exec chmod 644 {} \; 2>/dev/null || true
        [ -f "$HOME/.ssh/config" ] && chmod 644 "$HOME/.ssh/config"
        [ -f "$HOME/.ssh/known_hosts" ] && chmod 644 "$HOME/.ssh/known_hosts"
    fi
}
    
configure_macos() {
    echo "Configuring essential macOS settings..."
    
    # Security settings
    # The following disables macOS Gatekeeper quarantine (not recommended for security reasons).
    # It is intentionally commented out to preserve system protection.
    #defaults write com.apple.LaunchServices LSQuarantine -bool false
    
    # UI improvements
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    #defaults write com.apple.finder ShowPathbar -bool true
    #defaults write com.apple.finder ShowStatusBar -bool true
    #defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    
    # Disable animations for faster performance
    defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
    defaults write com.apple.dock launchanim -bool false
    
    # Function keys as standard function keys
    #defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
    
    # Show battery percentage
    defaults write com.apple.menuextra.battery ShowPercent -string "YES"
    
    # Restart affected applications
    killall Finder 2>/dev/null || true
    killall Dock 2>/dev/null || true
    killall SystemUIServer 2>/dev/null || true
}

# Main installation function
main() {
    echo "Starting minimal dotfiles installation..."
    
    install_xcode_tools
    install_homebrew
    install_homebrew_packages
    install_node_via_nvm
    install_npm_packages
    configure_zsh
    configure_git
    setup_ssh_keys
    configure_macos
    
    echo "Installation completed!"
    echo "Please restart your terminal to apply all changes."
}

# Run the installation
main "$@"

