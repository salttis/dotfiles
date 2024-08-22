#!/usr/bin/env bash

set -e

export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES="${DOTFILES:-$SCRIPT_DIR}"

. "$DOTFILES"/lib/functions.sh

# * System checks
# * =============================

check_system() {
	echo_info "Checking system..."
	_osname=$(uname)
	if [ "$_osname" != "Darwin" ]; then
		fail "Non-Apple system detected."
	fi
}

update_dotfiles() {
	if [ -d "$DOTFILES/.git" ]; then
		echo_info "Updating dotfiles..."
		git --work-tree="$DOTFILES" --git-dir="$DOTFILES/.git" pull origin master 2>/dev/null || true
	fi
}

request_sudo_privileges() {
	echo "Certain commands require root privileges so we need to initiate a valid sudo session."
	sudo -v
}

# * Install macOS developer tools
# * =============================

check_and_install_xcode() {
	if ! xcode-select -p &>/dev/null; then
		echo_info "Installing Xcode Command Line Tools..."
		xcode-select --install
		echo_info "Press any key when the installation has completed."
		read -nr 1

		# Accept Xcode license
		sudo xcodebuild -license accept
	fi
}

check_and_install_rosetta() {
	if ! /usr/bin/pgrep -q oahd; then
		echo_info "Rosetta is not installed. Installing..."
		if ! softwareupdate --install-rosetta --agree-to-license; then
			echo_warn "Rosetta installation failed."
		fi
	fi
}

# * Create symlinks and copy example files
# * ======================================

create_symlinks() {
	local _files
	local _symlinked

	echo_info "Symlinking all files ending in '.symlink'"

	_files=$(find "$DOTFILES" -name '*.symlink')
	for abs_file in $_files; do
		_symlinked=".$(basename "${abs_file%.symlink}")"
		ln -sfv "$abs_file" "$HOME/$_symlinked"
	done

	echo
}

create_config_symlinks() {
	local _files
	local _symlinked

	echo_info "Symlinking all files in config folder."

	mkdir "$HOME"/.config || true

	_files=$(find "$DOTFILES/config" -mindepth 1)
	for abs_file in $_files; do
		_symlinked="$(basename "${abs_file}")"
		ln -sfv "$abs_file" "$HOME/.config/$_symlinked"
	done

	echo

}

copy_example_files() {
	local _files
	local _example

	echo_info "Copying all files ending in '.example' to your home directory."

	_files=$(find "$DOTFILES" -name '*.example')
	for abs_file in $_files; do
		_example=".$(basename "${abs_file%.example}")"
		# Check that the file doesnt already exist
		[ -f "$HOME/$_example" ] && echo_warn "File already exists: $HOME/$_example" && continue
		cp -v -n "$abs_file" "$HOME/$_example"
	done

	echo
}

# * Run install and setup scripts
# * ======================================

run_install_scripts() {
	for file in $(find $DOTFILES -name 'install.sh'); do
		echo_info "Running ${file#$DOTFILES/}..."
		bash "$file"
	done

	echo
}

run_setup_scripts() {
	for file in $(find $DOTFILES -name 'setup.sh'); do
		echo_info "Setting up ${file#DOTFILES/}..."
		bash "$file"
	done

	echo
}

# * Run system software update
# * ==========================

run_system_softwareupdate() {
	echo_info "Running system software update..."
	sudo softwareupdate -i -a
}

# * ====
# * ====

main() {
	check_system
	update_dotfiles
	request_sudo_privileges
	check_and_install_xcode
	check_and_install_rosetta
	create_symlinks
	create_config_symlinks
	copy_example_files
	run_install_scripts
	run_setup_scripts
	run_system_softwareupdate
}

main "$@"
