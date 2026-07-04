#/bin/bash

if command -v python3 >/dev/null 2>&1; then
    PYTHON_CMD=python3
elif command -v python >/dev/null 2>&1; then
    PYTHON_CMD=python
else
    echo "Python not found! Skipping asciinema installation..." >/dev/stderr
    exit 1
fi
$PYTHON_CMD -m pip install --user asciinema
unset PYTHON_CMD
