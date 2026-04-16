alias nikofetch='fastfetch'

if (( $COLUMNS > 52 )); then
    fortune $HOME/.zsh/data/wm-fortunes | twm-rs -w 45 -h 11 -x 2 -y 0
fi
if (( $COLUMNS > 62 )); then
    printf '\033[4A'
    {
        todo-checker "$HOME/Notes/obsidian/vault1/"
        echo "- - - - - - - - - - - - - -"
        bday-check-rs "$HOME/Notes/obsidian/vault1/Birthday List.md" 20
    } | twm-rs -w auto -h auto -a left -x 6 -y 0 -t 0 --clear --color 93
elif (( $COLUMNS > 56 )); then
    {
        todo-checker "$HOME/Notes/obsidian/vault1/"
        echo "- - - - - - - - - - - - - -"
        bday-check-rs "$HOME/Notes/obsidian/vault1/Birthday List.md" 20
    } | twm-rs -w auto -h auto -a left -x 0 -y 0 -t 0 --clear --color 93
fi

TMOUT=300

TRAPALRM() {
    if (( $LINES > 15 && $COLUMNS > 113 )); then
        tclock --screensaver -s 2 -c "#B134EB"
    else
        drift
    fi
}

