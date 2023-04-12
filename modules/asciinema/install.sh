#/bin/bash

[[ -z "$(which python3)" ]] && sudo apt install -y python3
python3 -m pip install --user asciinema
# if [[ $(readYN "enable recording? (DOES NOTHING RN)" 'y') == 'y' ]]; then
#     #todo
# fi