# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Zinit
source $HOMEBREW_PREFIX/opt/zinit/zinit.zsh

# Plugin for Node Version Manager
zinit wait lucid light-mode for lukechilds/zsh-nvm

# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma-continuum/history-search-multi-word

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# Powerlevel10k theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## Aliases

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

alias rm_node_modules="fd 'node_modules' -u | \
  xargs du -sh | \
  sort -hr | \
  fzf -m --header 'Select node_modules to remove' --preview 'cat {2}../package.json' | \
  awk '{print $2}' | \
  xargs -r rm -rf"

# Homebrew
alias bu="brew update && brew upgrade && brew cleanup -s"
alias buc="brew update && brew upgrade --cask && brew cleanup -s"
alias bi="brew install"

# Zinit
alias zu="zinit self-update && zinit update"
