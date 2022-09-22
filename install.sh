#!/bin/bash

# Since this script isn't guaranteed to be in $PWD, get accurate DOTFILES_DIR
DOTFILES_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# ensure readYN is on path
export PATH="$DOTFILES_DIR/scripts:$PATH"

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
			rm -rf "$DOTFILES_DIR/backup/$(basename "$target_file").bak"
			mv -v "$target_file" "$DOTFILES_DIR/backup/$(basename "$target_file").bak"
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


if [ "$OS_TYPE" = "msys" ]; then
	echo "!!WARNING!! MSYS is not fully supported, use at your own risk!"
	[ $(readYN "Continue?" 'n') == 'n' ] && exit
fi

echo "Updating submodules..."
git submodule update --depth 1 --init --recursive


# Create backup folders
if [[ ! -d "$DOTFILES_DIR/backup" ]]; then
	echo "Creating $(basename "$DOTFILES_DIR")/backup..."
	mkdir "$DOTFILES_DIR/backup"
fi

echo "Existing dotfiles will be copied to $(basename $DOTFILES_DIR)/backup"
echo "Installing dotfiles..."

# Copy all relevant dotfiles to the home directory
ignored_files=".git .gitconfig .githooks .gitignore .gitmodules apt-dependencies gdb-printers bin scripts backup TODO.md install.sh uninstall.sh bash_include"
for file in $(find "$DOTFILES_DIR" -maxdepth 1 ! -wholename "$DOTFILES_DIR"); do
	if grep -q "$(basename "$file")" <<< "$ignored_files"; then
		continue
	fi
	case "$(basename "$file")" in
		*.inc)
			base_file="$(basename "${file::-4}")"
			if [[ ! -e "$HOME/$base_file" || $(readYN "Overwrite ~/$base_file?" 'n') == 'y' ]]; then
				copyWithBackup "$file" "$HOME/$base_file" copy
			fi
			;;
		*)
			copyWithBackup "$file" "$HOME/$(basename "$file")" backup
			;;
	esac
done

# Install apt dependencies
[[ -n "$(which apt 2>/dev/null)" ]] && installer=apt
[[ -n "$(which dnf 2>/dev/null)" ]] && installer=dnf
if [[ -n "$installer" && $(readYN "Install $installer dependencies?" 'n') == 'y' ]]; then
	echo "Installing dependencies..."
	packagelist="$DOTFILES_DIR/apt-dependencies"
	sudo $installer update
	# sourced from https://askubuntu.com/questions/252734/apt-get-mass-install-packages-from-a-file
	xargs -a <(awk '! /^ *(#|$)/' "$packagelist") -r -- sudo $installer install -y
	echo
fi
# Install pwndbg
if [[ ! -d "$HOME/.pwndbg" && $(readYN "Install pwndbg?" 'n') == 'y' ]]; then
	echo "Installing pwndbg to ~/.pwndbg..."
	git clone https://github.com/pwndbg/pwndbg $HOME/.pwndbg
	pushd $HOME/.pwndbg &> /dev/null
	./setup.sh
	popd &> /dev/null
	sed -i '$d' "$HOME/.gdbinit"
	echo
fi
# Install gdb-gef
if [[ ! -f "$HOME/.gdbinit-gef.py" && $(readYN "Install gdb-gef?" 'n') == 'y' ]]; then
	echo "Installing GEF to ~/.gdbinit-gef.py..."
	[[ -z "$(which curl)" ]] && sudo apt install -y curl
	curl -L https://gef.blah.cat/py > "$HOME/.gdbinit-gef.py"
	echo
fi
# Install asciinema
if [[ -n "$(which python3)" && -z "$(which asciinema)" && $(readYN "Install asciinema?" 'n') == 'y' ]]; then
	echo "Installing asciinema..."
	[[ -z "$(which python3)" ]] && sudo apt install -y python3
	python3 -m pip install --user asciinema
	if [[ $(readYN "enable recording? (DOES NOTHING RN)" 'y') == 'y' ]]; then
		#todo
	fi
	echo
fi

# Optionally set custom git user info
if [[ "$(git config --global user.name)" == "exdeejay" && $(readYN "Set git name and email?" 'n') == 'y' ]]; then
	read -ep "Name: " git_name
	read -ep "Email: " git_email
	git config --global user.name "$git_name"
	git config --global user.email "$git_email"
	unset git_name
	unset git_email
	echo
fi

# Create local bash folder for scripts to be included in .bashrc
if [ ! -d "$HOME/.bash_include" ]; then
	echo "Creating ~/.bash_include..."
	mkdir "$HOME/.bash_include"
fi

if [[ "$(git config --local core.hooksPath)" != ".githooks/" ]]; then
	echo "Setting up .githooks/..."
	pushd "$DOTFILES_DIR" &> /dev/null
	git config --local core.hooksPath .githooks/
	popd &> /dev/null
	echo
fi

echo "done"

