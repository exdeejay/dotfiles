#/bin/bash

git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm
pushd $HOME/.nvm &>/dev/null
git checkout v0.39.4 &>/dev/null
popd &>/dev/null

if [[ $(readYN "[+] Install latest version of node?" 'y') == 'y' ]]; then
	source $HOME/.nvm/nvm.sh
	nvm install node
fi

