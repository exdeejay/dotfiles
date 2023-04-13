#!/usr/bin/env bash

BASE16_SHELL_VIM_AIRLINE_PATH="$BASE16_CONFIG_PATH/set_airline_theme.vim"

if [ -f "$BASE16_SHELL_VIM_AIRLINE_PATH" ]; then
  touch "$BASE16_SHELL_VIM_AIRLINE_PATH"
fi

read current_theme_name < "$BASE16_SHELL_THEME_NAME_PATH"
current_theme_name_underscores="${current_theme_name//-/_}"

vim_airline_output="if !exists('g:airline_theme') || g:airline_theme != 'base16_$current_theme_name_underscores'\n"
vim_airline_output+="  let g:airline_theme = 'base16_$current_theme_name_underscores'\n"
vim_airline_output+="endif"

echo -e "$vim_airline_output" >| "$BASE16_SHELL_VIM_AIRLINE_PATH"
