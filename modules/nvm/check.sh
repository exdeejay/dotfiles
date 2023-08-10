#/bin/bash

[[ -n "$(which nvm | grep -Ev "^alias" 2>/dev/null)" ]]
exit $?
