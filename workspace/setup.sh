#!/usr/bin/env bash

. "$DOTFILES"/lib/functions.sh

folders=(
    "$HOME/Projects"
)

tools=(
    yarn
    browser-sync
    eslint
    pnpm
    prettier
    serve
    typescript
    vercel
    contentful-cli
)

echo_info "Setting up workspace..."

function create_folders() {
    for dir in "${folders[@]}"; do
        if [ -d "$dir" ]; then
            echo "Directory already exists: $dir"
        else
            mkdir -p "$dir" && echo "Directory created successfully: $dir"
        fi
    done
}

install_node_via_nvm() {

    # Load NVM environment
    echo_info "Loading NVM environment..."

    export NVM_COMPLETION="true"
    export NVM_SYMLINK_CURRENT="true"
    export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"                                       # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

    echo_info "Installing latest Node.js LTS..."

    nvm install --lts

}

install_node_tools_via_volta() {

    # Load Volta environment
    echo_info "Loading Volta environment..."

    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"

    echo_info "Installing global Node.js tools via Volta..."

    echo_info "Installing: ${tools[*]}"

    volta install ${tools[*]}

}

sync_ssh_files_from_icloud() {
    mkdir -p "$HOME/.ssh" 2>/dev/null || true
    ln -s "$HOME"/Library/Mobile\ Documents/com~apple~CloudDocs/Workspace/ssh/* "$HOME"/.ssh 2>/dev/null
}

create_folders
install_node_via_nvm
install_node_tools_via_volta
sync_ssh_files_from_icloud

echo_info "Workspace setup done."
