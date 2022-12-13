echo "Installing pwndbg to ~/.pwndbg..."
git clone https://github.com/pwndbg/pwndbg $HOME/.pwndbg
pushd $HOME/.pwndbg &> /dev/null
./setup.sh
popd &> /dev/null
sed -i '$d' "$HOME/.gdbinit"