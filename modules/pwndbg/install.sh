#/bin/bash
set -eu

if ! command -v git >/dev/null 2>&1; then
    echo "git not installed! Skipping pwndbg installation..." >/dev/stderr
    exit 1
fi

echo "Installing pwndbg to ~/.pwndbg..."
git clone https://github.com/pwndbg/pwndbg "$HOME/.pwndbg"
pushd $HOME/.pwndbg &> /dev/null
(cd "$HOME/.pwndbg" && ./setup.sh)

# Remove source command on the last line of .gdbinit that pwndbg added
sed -i '$d' "$HOME/.gdbinit"
