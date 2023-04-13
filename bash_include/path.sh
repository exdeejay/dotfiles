#!/bin/bash

# set PATH so it includes user's private bin if it exists
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# only enable `bin` if we can actually run them
[[ "$(uname -m)" == "x86_64" ]] && export PATH="$ROOT_DIR/bin:$PATH"

export PATH="$ROOT_DIR/scripts:$PATH"

if [[ -d "$HOME/.nvm" ]]; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
