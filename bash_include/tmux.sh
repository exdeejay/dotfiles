#!/bin/bash


attach() {
	if [[ -z "$TMUX" && "$-" =~ i ]]; then
		if [[ "$RECORD" == "yes" ]]; then
			record_command tmux new-session -t session-group
			exit
		else
			exec tmux new-session -t session-group
		fi
	fi
}

detach() {
	tmux detach -E 'DETACH=yes RECORD=no $SHELL -li'
}

