#!/bin/bash

# Since this script isn't guaranteed to be in $PWD, get accurate DOTFILES_DIR
ROOT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
BACKUP_DIR="$ROOT_DIR/backup"
DOTFILES_DIR="$ROOT_DIR/files"
SCRIPTS_DIR="$ROOT_DIR/scripts"
INSTALLMODULES_DIR="$ROOT_DIR/installmodules"
GITHOOKS_DIR=".githooks" # has to be relative to repo directory ($ROOT_DIR)
DOTDIRS=(
	".config/nvim"
	".tmux"
	".vim"
)



getRelativePath() {
	echo "$(basename "$ROOT_DIR")/$(realpath --relative-to="$ROOT_DIR" "$1")"
}

# Backup and overwrite file with symlink
# Usage: copyWithBackup <sourcefile> <destfile> ["backup"/"copy"]
copyWithBackup() {
	source_file=$1
	target_file=$2
	mode=$3

	# Don't do anything if the target is already a link to the source file
	if [[ "$(readlink -f "$target_file")" != "$(realpath "$source_file")" ]]; then
		# Back up the target file if it already exists
		if [[ -e "$target_file" ]]; then
			rm -rf "$BACKUP_DIR/$(basename "$target_file").bak"
			mv -v "$target_file" "$BACKUP_DIR/$(basename "$target_file").bak"
		fi

		# Copy file if this is msys (no symlinks)
		if [[ "$mode" == "copy" || "$OS_TYPE" == "msys" ]]; then
			printf "copied "
			cp -v "$source_file" "$target_file"
		else # Symlink relatively otherwise
			printf "linked "
			ln -srv "$source_file" "$target_file"
		fi
	fi
}

installDotfiles() {
	target_dir="$1"
	# Copy all relevant dotfiles to the target directory
	for file in $(find "$DOTFILES_DIR" -maxdepth 1 -type f); do
		case "$file" in
			*.inc)
				base_file="$(basename "${file::-4}")"
				if [[ ! -e "$target_dir/$base_file" || $(readYN "Overwrite ~/$base_file?" 'n') == 'y' ]]; then
					copyWithBackup "$file" "$target_dir/$base_file" copy
				fi
				;;
			*)
				copyWithBackup "$file" "$target_dir/$(basename "$file")" backup
				;;
		esac
	done
}

installDotDirs() {
	target_dir="$1"
	for dir in "${DOTDIRS[@]}"; do
		copyWithBackup "$DOTFILES_DIR/$dir" "$target_dir/$dir" backup
	done
}

installDependencies() {
	[[ -n "$(which apt 2>/dev/null)" ]] && installer=apt
	[[ -n "$(which dnf 2>/dev/null)" ]] && installer=dnf
	if [[ -n "$installer" && $(readYN "Install $installer dependencies?" 'n') == 'y' ]]; then
		echo "Installing dependencies..."
		packagelist="$ROOT_DIR/apt-dependencies"
		if [[ "$installer" == "apt" ]]; then
			sudo $installer update
		fi
		# sourced from https://askubuntu.com/questions/252734/apt-get-mass-install-packages-from-a-file
		xargs -a <(awk '! /^ *(#|$)/' "$packagelist") -r -- sudo $installer install -y
		echo
	fi
}

runInstallModules() {
	for module in "$INSTALLMODULES_DIR"/*; do
		module_name="$(basename "$module")"
		bash "$module"/check.sh > /dev/null
		if [[ $? != 0 && $(readYN "Install $module_name?" 'n') == 'y' ]]; then
			echo "Installing $module_name..."
			bash "$module"/install.sh
			if [[ $? != 0 ]]; then
				echo "$module_name install failed! continuing..."
			fi
			echo
		fi
	done
}

setupGitConfig() {
	# Optionally set custom git user info
	if [[ "$(git config --global user.name)" == "exdeejay" && $(readYN "Change git name and email from the default?" 'n') == 'y' ]]; then
		read -ep "Name: " git_name
		read -ep "Email: " git_email
		git config --global user.name "$git_name"
		git config --global user.email "$git_email"
		unset git_name
		unset git_email
		echo
	fi
}



# ensure readYN is on path
export PATH="$SCRIPTS_DIR:$PATH"

if [ "$OS_TYPE" = "msys" ]; then
	echo "!!WARNING!! MSYS is not fully supported, use at your own risk!"
	[ $(readYN "Continue?" 'n') == 'n' ] && exit
fi

echo "Updating submodules..."
git -C "$ROOT_DIR" submodule update --depth 1 --init --recursive

# Create backup folders
if [[ ! -d "$BACKUP_DIR" ]]; then
	echo "Creating $(getRelativePath "$BACKUP_DIR")..."
	mkdir "$BACKUP_DIR"
fi

echo "Existing dotfiles will be copied to $(getRelativePath "$BACKUP_DIR")"
echo "Installing dotfiles from files..."
installDotfiles "$HOME"
installDotDirs "$HOME"
installDependencies
runInstallModules
setupGitConfig

# Create local bash folder for scripts to be included in .bashrc
if [ ! -d "$HOME/.bash_include" ]; then
	echo "Creating ~/.bash_include..."
	mkdir "$HOME/.bash_include"
fi

if [[ "$(git -C "$ROOT_DIR" config --local core.hooksPath)" != "$GITHOOKS_DIR" ]]; then
	echo "Setting up githooks to point to $GITHOOKS_DIR..."
	git -C "$ROOT_DIR" config --local core.hooksPath "$GITHOOKS_DIR"
fi

echo "done"
