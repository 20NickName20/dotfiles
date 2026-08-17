#!/bin/bash
filename="$(fzf --walker-root ~/Music | sed -e "s#$HOME/Music/##g")"
echo "$filename"
mpc add "$filename"

