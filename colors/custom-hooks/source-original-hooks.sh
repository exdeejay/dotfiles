#!/usr/bin/env bash

for hook in "$BASE16_SHELL_PATH/hooks"/*.sh; do
	[ -x "$hook" ] && . "$hook"
done
