#!/bin/bash

# Run a shell that records input with asciinema, or a normal shell if it isn't installed. Returns upon shell exit.
record_command() {
    if ! command -v asciinema >/dev/null 2>&1; then
        echo "error: asciinema not found, running normal shell" >/dev/stderr
        $SHELL
        return
    fi

    [[ ! -d "$HOME/.casts" ]] && mkdir "$HOME/.casts"
    if [[ ! -d "$HOME/.casts/$(date -I)" ]]; then
        if [[ -n "$(find "$HOME/.casts" -mindepth 1 -maxdepth 1 ! -iname '*.tar.gz')" ]]; then
            for dir in "$(find "$HOME/.casts" -mindepth 1 -maxdepth 1 ! -iname '*.tar.gz')"; do
                # TODO: zip up previously unzipped casts before tarring
                tar -C "$(dirname "$dir")" -czf "$dir.tar.gz" "$(basename "$dir")"
                rm -r "$dir"
            done
        fi
        mkdir -p "$HOME/.casts/$(date -I)"
    fi
    CAST_OUTPUT="$HOME/.casts/$(date -I)/$(date -u +%T).cast"
    asciinema rec -q -i 5 -c "$*" "$CAST_OUTPUT"
    gzip "$CAST_OUTPUT"
}

attach() {
    if ! command -v tmux >/dev/null 2>&1; then
        echo "error: tmux not installed, launching shell" >/dev/stderr
        exec bash
    fi

    if [[ ! -v TMUX && "$-" =~ i ]]; then
        [[ "$PWD" != "$HOME" && -n "$(tmux ls -F "#{session_group}" 2>/dev/null | grep -E "\S")" ]] && create_window=yes
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
