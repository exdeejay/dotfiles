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

if [ "$OSTYPE" == "msys" ]; then
	echo "!!! VERY DANGER !!!"
	echo "Not implemented yet! May remove stuff you need!"
	echo "Exiting..."
	return
fi


echo "Removing dotfiles..."

removeLinks() {
	target_dir=$1

	for link in $(find "$target_dir" -maxdepth 1 -type l); do
		if [ "$(dirname $(realpath "$link"))" == "$DOTFILES_DIR" ]; then
			rm -rf "$link"
			echo "Removed $(basename "$link")"
		fi
	done
}

removeLinks "$HOME"
removeLinks "$HOME/.local/bin"

echo "done"

