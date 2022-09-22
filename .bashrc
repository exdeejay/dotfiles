# If not running interactively, don't do anything
[[ $- =~ i ]] || return

DOTFILES_DIR="$(dirname "$(realpath ".bashrc")")"
[[ -z "$RECORD" ]] && RECORD="no"

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

