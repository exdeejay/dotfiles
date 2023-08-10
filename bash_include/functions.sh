#!/bin/bash

record_command() {
	[[ ! -d "$HOME/.casts" ]] && mkdir "$HOME/.casts"
	if [[ ! -d "$HOME/.casts/$(date -I)" ]]; then
		if [[ -n "$(find "$HOME/.casts" -mindepth 1 -maxdepth 1 ! -iname '*.tar.gz')" ]]; then
			for dir in "$(find "$HOME/.casts" -mindepth 1 -maxdepth 1 ! -iname '*.tar.gz')"; do
				# TODO: zip up previously unzipped casts before tarring
				tar -C "$(dirname "$dir")" -czf "$dir.tar.gz" "$(basename "$dir")"
				rm -r "$dir"
			done
		fi
		mkdir -p "$HOME/.casts/$(date -I)"
	fi
	CAST_OUTPUT="$HOME/.casts/$(date -I)/$(date -u +%T).cast"
	asciinema rec -q -i 5 -c "$*" "$CAST_OUTPUT"
	gzip "$CAST_OUTPUT"
}

