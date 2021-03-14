#!/usr/bin/env bash

cd "$(dirname $0)"

DOTFILES_DIR="$(pwd)"

echo "Installing dotfiles..."




if [ ! -d "backup" ]; then
	mkdir backup
fi
for dotfile in .*; do
	case $dotfile in
		.|..|*.git*) continue;;
		*)
			if [ -a "$HOME/$dotfile" ]; then
				mv "$HOME/$dotfile" "backup/$dotfile.bak"
			fi
			ln -s "$DOTFILES_DIR/$dotfile" "$HOME/$dotfile"
			;;
	esac
done


set_git_creds="notset"
while [ "$set_git_creds" != "y" -a "$set_git_creds" != "n" -a "$set_git_creds" != "" ]; do
	printf 'Set git username and email? (y/[n]): '
	read -e set_git_creds
done

if [ "$set_git_creds" == "y" ]; then
	printf "Username: "
	read -e git_username
	printf "Email: "
	read -e git_email
	git config --global user.name "$git_username"
	git config --global user.email "$git_email"
	unset git_username
	unset git_email
fi
unset set_git_creds



if [ ! -a "$HOME/bin" ]; then
	ln -s "$DOTFILES_DIR/bin" "$HOME/bin"
fi

if [ ! -d "$HOME/.bash_include" ]; then
	mkdir "$HOME/.bash_include"
fi


echo "done"

