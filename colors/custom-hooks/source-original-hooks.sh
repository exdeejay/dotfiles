#!/bin/bash

for hook in "$BASE16_SHELL_PATH/hooks"/*.sh; do
    [[ -r "$hook" ]] && source "$hook"
done
