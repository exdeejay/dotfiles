#/bin/bash
set -eu

if ! command -v git >/dev/null 2>&1; then
    echo "git not installed! Skipping nvm installation..." >/dev/stderr
    exit 1
fi

git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm

if [[ $(readYN "[+] Install latest version of node?" 'y') == 'y' ]]; then
	source $HOME/.nvm/nvm.sh
	nvm install node
fi

