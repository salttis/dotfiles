#!/usr/bin/env bash

. "$DOTFILES"/lib/functions.sh

if ! type "brew" >/dev/null 2>&1; then
    echo -e "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"" | pbcopy
    fail "Homebrew not found, install it first. Installation command copied to clipboard."
fi

brew bundle install --file $DOTFILES/homebrew/Brewfile --no-lock
