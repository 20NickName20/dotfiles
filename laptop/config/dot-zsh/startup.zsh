alias nikofetch='fastfetch'

clear
printf '\033[0;0H'
fortune $HOME/.zsh/data/wm-fortunes | twm-rs -w 50 -h 13 -x 2 -y 0
printf '\033[15;0H'
{
    todo-checker "$HOME/Notes/obsidian/vault1/"
    echo "- - - - - - - - - - - - - -"
    bday-check-rs "$HOME/Notes/obsidian/vault1/Birthday List.md" 20
} | twm-rs -w auto -h auto -a left -x 6 -y 0 -t 0 --clear --color 93

TMOUT=300

TRAPALRM() {
    if (( $LINES > 15 && $COLUMNS > 113 )); then
        tclock --screensaver -s 2 -c "#B134EB"
    else
        drift
    fi
}

