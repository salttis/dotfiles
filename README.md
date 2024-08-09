# Dotfiles

```sh
DOTFILES="~/.dotfiles" git clone https://github.com/salttis/dotfiles.git $DOTFILES && $DOTFILES/setup
```

## What these dotfiles do?

- Set up macOS with required developer tools
    - Xcode with Command Line Tools
    - Rosetta
- Creates symlinks for shared system configuration
    - ZSH with aliases
    - SSH
- Copies example files for environment configuration
- Creates shared XDG configurations files
- Runs installations scripts for
    - Homebrew packages
    - Homebrew cask packages
    - Fonts
    - VSCode plugins
    - App Store applications
- Sets up macOS system settings
    - Sensible system defaults
    - Desktop & Dock behaviour
- Keeps the system and applications updated

## TODO

- [ ] Look into [mackup](https://github.com/lra/mackup)
- [ ] Sync VSCode config
- [ ] How to install Rise calendar
