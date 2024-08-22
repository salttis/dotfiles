# Dotfiles

```sh
DOTFILES="~/.dotfiles" git clone https://github.com/salttis/dotfiles.git $DOTFILES && cd $DOTFILES && chmod +x run.sh && ./run.sh
```

# Dotfiles flow

1. Check system
2. Self-update
3. Request sudo privileges

4. Check and install XCode and Command Line Tools
5. Check and install Rosetta

6. Create symbolic links
7. Create configuration symbolic links
8. Copy example files

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
       - SSH

11. Check for system updates
