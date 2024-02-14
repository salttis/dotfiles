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

apps_to_add=(
    "/Applications/Arc.app"
    "/Applications/Spark Desktop.app"
    "/Applications/Rise.app"
    "/Applications/Slack.app"
    "/System/Applications/App Store.app"
    "/System/Applications/System Settings.app"
    "/Applications/kitty.app"
    "/Applications/Visual Studio Code.app"
)

for app in "${apps_to_remove[@]}" "${apps_to_add[@]}"; do
    dockutil --remove "$app" --no-restart --allhomes
done

killall Dock

for app in "${apps_to_add[@]}"; do
    dockutil --add "$app" --no-restart
done

defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock autohide -bool true
defaults write com.apple.Dock size-immutable -bool true

killall Dock