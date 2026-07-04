#/bin/bash
set -eu

if ! command -v curl >/dev/null 2>&1; then
    echo "curl not installed! Skipping gdb-gef installation..." >/dev/stderr
    exit 1
fi

echo "Installing GEF to ~/.gdbinit-gef.py..."
curl -L https://gef.blah.cat/py > "$HOME/.gdbinit-gef.py"
