#!/bin/bash

# Since this script isn't guaranteed to be in $PWD, get accurate ROOT_DIR
ROOT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# Remove all symbolic links in a directory pointing to anywhere in ROOT_DIR
# Usage: removeLinks <targetdir>
removeLinks() {
	target_dir=$1

	for link in $(find "$target_dir" -maxdepth 1 -type l); do
		if [[ "$(dirname $(realpath "$link"))" =~ "$ROOT_DIR" ]]; then
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

