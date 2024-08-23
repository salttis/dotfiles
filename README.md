# Dotfiles

```sh
git clone https://github.com/salttis/dotfiles.git ~/.dotfiles
~/.dotfiles/run.sh
```

# Dotfiles flow

1. Check system
2. Self-update
3. Request sudo privileges

4. Check and install XCode and Command Line Tools
5. Check and install Rosetta

6. Create symbolic links
   1. Setup shared zsh configuration
      - Some useful aliases
      - Adds zsh plugins with Zinit plugin manager
        - lukechilds/zsh-nvm - Lazyloaded NVM
        - zdharma-continuum/history-search-multi-word - Better Ctrl-R history
        - zsh-users/zsh-autosuggestions - Fish-like autosuggestions
        - zdharma-continuum/fast-syntax-highlighting - Syntax highlighting
        - starship/starship - Zsh terminal theme
7. Create shared XDG configuration
8. Copy example files for system specific configuration (not symlinks)

9. Run install scripts

   1. Install Homebrew bundle
      - CLI Apps
      - Cask Apps
      - Fonts
      - VSCode Plugins

10. Run setup scripts

    1. Setup macOS
       - System Settings
       - AppStore Applications
       - Desktop & Dock Behaviour
    2. Setup workspaces
       - Folders
       - Sync SSH keys from iCloud

11. Check for system updates
