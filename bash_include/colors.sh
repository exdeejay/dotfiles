BASE16_THEME_DEFAULT="atelier-lakeside"

# Base16 Shell
BASE16_SHELL_PATH="$ROOT_DIR/base16-shell"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && \
    source "$BASE16_SHELL_PATH/profile_helper.sh"
