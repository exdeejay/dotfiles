#!/bin/bash


# Since this script isn't guaranteed to be in $PWD, get accurate DOTFILES_DIR
SOURCE=${BASH_SOURCE[0]}
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
	SOURCE=$(readlink "$SOURCE")
	[[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DOTFILES_DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

# Prompt for a Y/N answer
# Usage: readYN <question> [default answer]
# Returns: 'y' or 'n' depending on user input
readYN() {
	if [[ "${2,,}" == "y" ]]; then
		choices="Yn"
	elif [[ "${2,,}" == "n" ]]; then
		choices="yN"
	else
		choices="yn"
	fi
	while true; do
		read -ep "$1 [$choices]: " selection
		[[ "${selection,,}" == "y" || "${selection,,}" == "n" ]] && break
		[[ -z "$selection" ]] && [[ "${2,,}" == "y" || "${2,,}" == "n" ]] && break
	done
	[[ -n "$selection" ]] && echo "${selection,,}" || echo "${2,,}"
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

echo "Existing dotfiles will be copied to $(basename $DOTFILES_DIR)/backup"
echo "Installing dotfiles..."

# Create backup folders
[ ! -d "$DOTFILES_DIR/backup" ] && mkdir "$DOTFILES_DIR/backup"
[ ! -d "$DOTFILES_DIR/backup/bin" ] && mkdir "$DOTFILES_DIR/backup/bin"

# Copy all relevant dotfiles to the home directory
ignored_files=".git .gitconfig .gitignore .gitmodules apt-dependencies bin backup TODO.md install.sh uninstall.sh"
for file in $(find "$DOTFILES_DIR" -maxdepth 1 ! -wholename "$DOTFILES_DIR"); do
	if grep -q "$(basename "$file")" <<< "$ignored_files"; then
		continue
	fi
	case "$(basename "$file")" in
		.gitconfig.inc)
			copyWithBackup "$file" "$HOME/.gitconfig" copy
			;;
		*)
			copyWithBackup "$file" "$HOME/$(basename "$file")" backup
			;;
	esac
done

# Install apt dependencies
if [[ -n "$(which apt)" && $(readYN "install apt dependencies?" 'n') == 'y' ]]; then
	packagelist="$DOTFILES_DIR/apt-dependencies"
	sudo apt-get update
	# sourced from https://askubuntu.com/questions/252734/apt-get-mass-install-packages-from-a-file
	xargs -a <(awk '! /^ *(#|$)/' "$packagelist") -r -- sudo apt-get install -y
fi
# Install pwndbg
if [[ ! -d "$HOME/.pwndbg" && $(readYN "install pwndbg?" 'y') == 'y' ]]; then
	git clone https://github.com/pwndbg/pwndbg $HOME/.pwndbg
	pushd $HOME/.pwndbg
	./setup.sh
	popd
	sed -i '$d' "$HOME/.gdbinit"
fi
# Install gdb-gef
if [[ ! -f "$HOME/.gdbinit-gef.py" && $(readYN "install gdb-gef?" 'y') == 'y' ]]; then
	curl https://gef.blah.cat/py > "$HOME/.gdbinit-gef.py"
fi
# Install asciinema
if [[ -n "$(which python3)" && -z "$(which asciinema)" && $(readYN "install asciinema?" 'y') == 'y' ]]; then
	python3 -m pip install --user asciinema
fi

# Optionally set custom git user info
if [[ $(readYN "set git username and email?" 'n') == 'y' ]]; then
	printf "Username: "
	read -e git_username
	printf "Email: "
	read -e git_email
	git config --global user.name "$git_username"
	git config --global user.email "$git_email"
	unset git_username
	unset git_email
else
	git config --global user.name "exdeejay"
	git config --global user.email "13634296+exdeejay@users.noreply.github.com"
fi

# Create local bash folder for scripts to be included in .bashrc
if [ ! -d "$HOME/.bash_include" ]; then
	mkdir "$HOME/.bash_include"
fi

git config --local core.hooksPath .githooks/

echo "done"

