# Path to the dotfiles.
export DOTFILES="$HOME/.dotfiles"

# Prefer Finnish and use UTF-8
export LC_ALL="fi_FI.UTF-8"
export LANG="fi_FI.UTF-8"

# Default .config folder
XDG_CONFIG_HOME="$HOME/.config"

# Start with a clean slate, with only the scripts in `~bin`.
PATH="$HOME/bin"

# Standard PATH entries.
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/bin"
export PATH="$PATH:/sbin"

# Default editor
export EDITOR="code"

# Node version manager
export NVM_COMPLETION=true
export NVM_SYMLINK_CURRENT=true

# Use a TTY in GPG.
export GPG_TTY="$(tty)"

# Virtuel environment
export VENV=~/.venv
