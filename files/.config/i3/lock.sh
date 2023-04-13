#!/bin/bash

SLEEP_DELAY=10
# set the icon and a temporary location for the screenshot to be stored
#icon="$HOME/images/lock-icon-light.png"
tmpbg='/tmp/screen.png'

revert() {
	xset dpms 0 0 0
}

rm -f "$tmpbg"
# take a screenshot
scrot "$tmpbg"
# blur the screenshot by resizing and scaling back up
mogrify -scale 10% -scale 1000% "$tmpbg"
# overlay the icon onto the screenshot
#convert "$tmpbg" "$icon" -gravity center -composite "$tmpbg"

# lock the screen with the blurred screenshot
trap revert HUP INT TERM
xset +dpms dpms $SLEEP_DELAY $SLEEP_DELAY $SLEEP_DELAY

# We set a trap to kill the locker if we get killed, then start the locker and
# wait for it to exit. The waiting is not that straightforward when the locker
# forks, so we use this polling only if we have a sleep lock to deal with.
if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
    kill_i3lock() {
        pkill -xu $EUID "$@" i3lock
    }

    trap kill_i3lock TERM INT

    # we have to make sure the locker does not inherit a copy of the lock fd
    i3lock -i "$tmpbg" {XSS_SLEEP_LOCK_FD}<&-

    # now close our fd (only remaining copy) to indicate we're ready to sleep
    exec {XSS_SLEEP_LOCK_FD}<&-

    while kill_i3lock -0; do
        sleep 0.5
    done
else
	i3lock -i "$tmpbg" --nofork
fi

revert

