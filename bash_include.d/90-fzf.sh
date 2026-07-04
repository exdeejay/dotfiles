#!/bin/bash
# Load fzf command completion and key bindings if present

if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --bash)"
fi
