# If not running interactively, don't do anything
[[ $- =~ i ]] || return

# Since this script isn't guaranteed to be in $PWD, get accurate DOTFILES_DIR
export DOTFILES_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
[[ -z "$RECORD" ]] && RECORD="yes"

source "$DOTFILES_DIR/bash_include/path.sh"
source "$DOTFILES_DIR/bash_include/aliases.sh"
source "$DOTFILES_DIR/bash_include/shopts.sh"
source "$DOTFILES_DIR/bash_include/functions.sh"

source "$DOTFILES_DIR/bash_include/tmux.sh"
if [[ -n "$(which fzf)" ]]; then
	source "$DOTFILES_DIR/bash_include/fzf-key-bindings.sh"
	source "$DOTFILES_DIR/bash_include/fzf-completion.sh"
fi

source "$DOTFILES_DIR/bash_include/misc.sh"

if [ -d "$HOME/.bash_include" ]; then
	for f in $(find "$HOME/.bash_include" -maxdepth 1 -type f); do
		source "$f"
	done
fi

[[ -z "$DETACH" && -n "$(which tmux)" ]] && attach || unset DETACH

