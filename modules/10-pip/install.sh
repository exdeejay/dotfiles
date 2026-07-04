#/bin/bash
set -eu

if command -v python3 >/dev/null 2>&1; then
    PYTHON_CMD=python3
elif command -v python >/dev/null 2>&1; then
    PYTHON_CMD=python
else
    echo "Python not found! Skipping pip installation..." >/dev/stderr
    exit 1
fi

echo "Running python3 -m ensurepip..."
$PYTHON_CMD -m ensurepip
unset PYTHON_CMD

