#!/bin/bash

# set PATH so it includes user's private bin if it exists
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# Add dotfiles scripts
export PATH="$ROOT_DIR/scripts:$PATH"

# Load nvm and node if present
if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    # Load nvm
    [[ -r "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" 
    # Load nvm bash_completion
    [[ -r "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion" 
fi

# Load cargo environment if present
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"
