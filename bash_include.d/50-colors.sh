#!/bin/bash
# Load base16 color profile

BASE16_SHELL_PATH="$ROOT_DIR/colors/tinted-shell"
if [[ ! -d "$BASE16_SHELL_PATH" ]]; then
    unset BASE16_SHELL_PATH
else
    if [[ -n "$PS1" && -s "$BASE16_SHELL_PATH/profile_helper.sh" ]]; then
        BASE16_THEME_DEFAULT="atelier-lakeside"
        BASE16_SHELL_HOOKS_PATH="$ROOT_DIR/colors/custom-hooks"
        BASE16_FZF_PATH="$ROOT_DIR/colors/tinted-fzf"
        source "$BASE16_SHELL_PATH/profile_helper.sh"
    fi
fi
