#!/bin/bash
# .bash_profile gets sourced if shell is login
# (-l flag or $0 starts with - like "-/bin/bash")

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc"
fi

