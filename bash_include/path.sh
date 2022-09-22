#!/bin/bash

# set PATH so it includes user's private bin if it exists
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# only enable `bin` if we can actually run them
[[ "$(uname -p)" == "x86_64" ]] && export PATH="$DOTFILES_DIR/bin:$PATH"

export PATH="$DOTFILES_DIR/scripts:$PATH"

