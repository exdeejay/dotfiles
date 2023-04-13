BASE16_THEME_DEFAULT="atelier-lakeside"

BASE16_FZF_PATH="$ROOT_DIR/colors/base16-fzf"
BASE16_SHELL_PATH="$ROOT_DIR/colors/base16-shell"
BASE16_SHELL_HOOKS_PATH="$ROOT_DIR/colors/custom-hooks"

export BASE16_SHELL="$BASE16_SHELL_PATH"


[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && \
    source "$BASE16_SHELL_PATH/profile_helper.sh"
