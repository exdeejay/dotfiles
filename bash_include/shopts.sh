#!/bin/bash

# append to the history file, don't overwrite it
shopt -s histappend

# combine multiline commands into one in history
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Automatically cd without prepending cd
shopt -s autocd

# Turn on extended glob patterns
shopt -s extglob

# Error when glob doesn't match any files
shopt -s failglob

# Match dotfiles when expanding globs
shopt -s dotglob

# Fix small spelling mistakes on cd
shopt -s cdspell

# Fix small spelling mistakes on tab completion
shopt -s dirspell

# Prevent shell redirection from overwriting files (use >| to override)
set -o noclobber

# Turn on vi keybinds
set -o vi

