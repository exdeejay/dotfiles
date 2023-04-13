#/bin/bash

echo "v0.39.2"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash &&
	sed -i "$(($(wc -l < "$HOME/.bashrc") - 3)),\$d" "$HOME/.bashrc"
