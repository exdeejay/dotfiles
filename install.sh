#!/usr/bin/env bash

readYN() {
	selection="notset"
	while [ "${selection,,}" != "y" -a "${selection,,}" != "n" -a "$selection" != "" ]; do
		printf "$1: " >&2
		read -e selection
	done
	case "${selection,,}" in
		y) echo 1;;
		n) echo 0;;
		*) echo 2;;
	esac
}

cd "$(dirname $0)"

DOTFILES_DIR="$PWD"

echo "Backing up existing dotfiles to $(basename $PWD)/backup"
echo "Installing dotfiles..."
if [ ! -d "backup" ]; then
	mkdir backup
fi
for dotfile in .*; do
	case $dotfile in
		.|..|.git|.gitignore) continue;;
		*)
			if [ -a "$HOME/$dotfile" ]; then
				rm -rf "backup/$dotfile.bak"
				mv -v "$HOME/$dotfile" "backup/$dotfile.bak"
			fi
			if [ "$OS_TYPE" == "msys" ]; then
				cp "$DOTFILES_DIR/$dotfile" "$HOME/$dotfile"
			else
				ln -s "$DOTFILES_DIR/$dotfile" "$HOME/$dotfile"
			fi
			;;
	esac
done


if [[ $(readYN "set git username and email? [yN]") == 1 ]]; then
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
touch "$HOME/.tmux.conf.local"

echo "done"

