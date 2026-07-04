#/bin/bash
set -eu

command -v pip >/dev/null 2>&1 || command -v pip3 >/dev/null 2>&1
exit $?
