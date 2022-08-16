#!/bin/bash

# Since this script isn't guaranteed to be in $PWD, get accurate DOTFILES_DIR
SOURCE=${BASH_SOURCE[0]}
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
	SOURCE=$(readlink "$SOURCE")
	[[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DOTFILES_DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

# Remove all symbolic links in a directory pointing to anywhere in DOTFILES_DIR
# Usage: removeLinks <targetdir>
removeLinks() {
	target_dir=$1

	for link in $(find "$target_dir" -maxdepth 1 -type l); do
		if [[ "$(dirname $(realpath "$link"))" =~ "$DOTFILES_DIR" ]]; then
			rm "$link"
			echo "Removed $(basename "$link")"
		fi
	done
}


if [ "$OSTYPE" == "msys" ]; then
	echo "!!! VERY DANGER !!!"
	echo "Not implemented yet! May remove stuff you need!"
	echo "Exiting..."
	return
fi

echo "Removing dotfiles..."


removeLinks "$HOME"

echo "done"

