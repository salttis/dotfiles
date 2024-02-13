#!/usr/bin/env bash

. $DOTFILES/lib/functions.sh

for dir in $HOME/Personal $HOME/Work; do
    if [ -d "$dir" ]; then
        echo "Directory already exists: $dir"
    else
        mkdir -p "$dir" && echo "Directory created successfully: $dir"
    fi
done