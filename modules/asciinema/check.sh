#/bin/bash
set -eu

command -v python3 >/dev/null 2>&1 && command -v asciinema >/dev/null 2>&1
exit $?
