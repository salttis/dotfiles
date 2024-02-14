#!/usr/bin/env bash

. $DOTFILES/lib/functions.sh

echo_info "Setting up Dock..."

apps_to_remove=(
    Launchpad
    Safari
    Messages
    Mail
    Maps
    Photos
    FaceTime
    Calendar
    Contacts
    Reminders
    Notes
    Freeform
    TV
    Music
    "App Store"
    "System Settings"
)

for app in "${apps_to_remove[@]}"; do
    echo "Removing $app"
    dockutil --remove "$app" --no-restart --allhomes 1&> /dev/null
done

defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Dock size-immutable -bool true

killall Dock