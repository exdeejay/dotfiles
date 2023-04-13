# If not running interactively, don't do anything
[[ $- =~ i ]] || return

# Since this script isn't guaranteed to be in $PWD, get accurate ROOT_DIR
DOTFILES_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
ROOT_DIR="$(realpath "$DOTFILES_DIR/..")"
[[ -z "$RECORD" ]] && RECORD="yes"

source "$ROOT_DIR/bash_include/env.sh"
source "$ROOT_DIR/bash_include/path.sh"
source "$ROOT_DIR/bash_include/aliases.sh"
source "$ROOT_DIR/bash_include/shopts.sh"
source "$ROOT_DIR/bash_include/functions.sh"
source "$ROOT_DIR/bash_include/tmux.sh"
if [[ -n "$(which fzf)" ]]; then
	source "$ROOT_DIR/bash_include/fzf-key-bindings.sh"
	source "$ROOT_DIR/bash_include/fzf-completion.sh"
fi
source "$ROOT_DIR/bash_include/misc.sh"

# Source local include files
if [ -d "$HOME/.bash_include" ]; then
	for f in $(find "$HOME/.bash_include" -maxdepth 1 -type f); do
		source "$f"
	done
fi

# Enter tmux
[[ -z "$DETACH" && -n "$(which tmux)" ]] && attach || unset DETACH

