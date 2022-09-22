#!/bin/bash


attach() {
	if [[ -z "$TMUX" && "$-" =~ i ]]; then
		[[ "$PWD" != "$HOME" && -n "$(tmux ls -F "#{session_group}" 2>/dev/null | egrep "\S")" ]] && create_window=yes
		# first window in new tmux session group
		tmux new-session -d -c "$PWD" -t session-group
		if [[ -n "$create_window" ]]; then
			tmux new-window -c "$PWD"
		fi

		if [[ "$RECORD" == "yes" ]]; then
			record_command tmux attach
			exit
		else
			exec tmux attach
		fi
	fi
}

detach() {
	tmux detach -E 'DETACH=yes RECORD=no $SHELL -li'
}

