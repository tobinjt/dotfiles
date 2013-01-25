# ~/.bash_logout: executed by bash(1) when login shell exits.

#clear
# read new lines from .bash_history
#history -n
# write
#history -w
# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
