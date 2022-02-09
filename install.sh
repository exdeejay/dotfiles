#!/usr/bin/env bash

readYN() {
	selection="notset"
	while [ "${selection,,}" != "y" -a "${selection,,}" != "n" -a "$selection" != "" ]; do
		printf "$1" >&2
		[ "${2,,}" == "y" ] && printf "[Yn]" >&2 || printf "[yN]" >&2
		printf ": " >&2
		read -e selection
	done
	[ "$selection" != "" ] && echo "${selection,,}" || echo "${2,,}"
}

SOURCE=${BASH_SOURCE[0]}
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
	SOURCE=$(readlink "$SOURCE")
	[[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DOTFILES_DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

cd "$DOTFILES_DIR"

if [ "$OS_TYPE" = "msys" ]; then
	echo "!!WARNING!! MSYS is not fully supported, use at your own risk!"
	[ $(readYN "Continue?" 'n') == 'n' ] && exit
fi

echo "Backing up existing dotfiles to $(basename $DOTFILES_DIR)/backup"
echo "Installing dotfiles..."

[ ! -d "backup" ] && mkdir backup
[ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin"
[ ! -d "backup/bin" ] && mkdir backup/bin

copyWithBackup() {

	src_dir=$1
	target_dir=$2
	ignored=$3

	cd -P "$src_dir"

	for file in $(ls -A); do
		[[ "$ignored" =~ "$file" ]] && continue
		# Check if file already exists
		if [ -a "$target_dir/$file" ]; then
			# Don't back up file if it's already symlinked here
			[ "$(dirname "$(readlink "$target_dir/$file")")" == "$PWD" ] && continue
			relative_path=$(realpath --relative-to="$DOTFILES_DIR" "$src_dir")
			# Copy file and overwrite old backup
			rm -rf "$DOTFILES_DIR/backup/$relative_path/$file.bak"
			mv -v "$target_dir/$file" "$DOTFILES_DIR/backup/$relative_path/$file.bak"
		fi
		# Copy file if this is msys (no symlinks)
		if [ "$OS_TYPE" == "msys" ]; then
			cp "$file" "$target_dir/$file"
		else
			ln -sv "$DOTFILES_DIR/$relative_path/$file" "$target_dir/$file"
		fi
	done
}

copyWithBackup "." "$HOME" ".git .gitignore .gitmodules bin backup TODO.md install.sh uninstall.sh"
copyWithBackup "bin" "$HOME/.local/bin"


if [ $(readYN "set git username and email?" 'n') == 'y' ]; then
	printf "Username: "
	read -e git_username
	printf "Email: "
	read -e git_email
	git config --global user.name "$git_username"
	git config --global user.email "$git_email"
	unset git_username
	unset git_email
fi


if [ ! -d "$HOME/.bash_include" ]; then
	mkdir "$HOME/.bash_include"
fi

echo "done"

