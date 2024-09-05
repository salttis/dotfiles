OS=$(echo $(uname) | tr '[:upper:]' '[:lower:]')

[ "$OS" = "windowsnt" ] && OS_WIN="yes"
[ "$OS" = "darwin" ] && OS_MAC="yes"
[ "$OS" = "linux" ] && OS_LIN="yes"

# `ls` replacement.
alias ll="eza --long --binary --group --classify --git --all"

# `cat` replacement.
alias cat="bat --paging=never --theme=base16 --style=header-filename,header-filesize,grid"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# Recursively delete `.DS_Store` files
alias clean-ds-stores="find . -name '*.DS_Store' -type f -ls -delete"

# Directories
alias ..="cd .."

# Git
alias gc="git clone "
alias gs="git status"
alias gg="lazygit"

# System
alias df="df -h"
alias du="du -h"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias largedirs="du -d2 -h -t2M | sort -hr"

[ -n "$OS_MAC" ] && alias nproc="sysctl hw.ncpu | awk '{print \$2}'"
CORES=$(nproc)
JOBS=$(expr $CORES + 1)
alias make="make -j$JOBS"

if [ -n "$OS_MAC" ]; then
  function free() {
    FREE_BLOCKS=$(vm_stat | grep free | awk '{ print $3 }' | sed 's/\.//')
    INACTIVE_BLOCKS=$(vm_stat | grep inactive | awk '{ print $3 }' | sed 's/\.//')
    SPECULATIVE_BLOCKS=$(vm_stat | grep speculative | awk '{ print $3 }' | sed 's/\.//')
    FREE=$((($FREE_BLOCKS + SPECULATIVE_BLOCKS) * 4096 / 1048576))
    INACTIVE=$(($INACTIVE_BLOCKS * 4096 / 1048576))
    TOTAL=$((($FREE + $INACTIVE)))
    echo "Free:       $FREE MB"
    echo "Inactive:   $INACTIVE MB"
    echo "Total free: $TOTAL MB"
  }
  alias free="free"
fi

alias rm_node_modules="fd 'node_modules' -u | \
  xargs du -sh | \
  sort -hr | \
  fzf -m --header 'Select node_modules to remove' --preview 'cat {2}../package.json' | \
  awk '{print $2}' | \
  xargs -r rm -rf"

# Vim
alias vim="nvim"
alias v="vim"

# Homebrew
alias bu="brew update && brew upgrade && brew cleanup -s"
alias buc="brew update && brew upgrade --cask && brew cleanup -s"
alias bi="brew install"

# Zinit
alias zu="zinit self-update && zinit update"
