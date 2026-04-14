alias tetofetch='fastfetch'

#obsidian tasks todo verbose 2> /dev/null | fold -w $(( $COLUMNS - 8 )) | lolcat -f | boxes -t 4 -d info
echo ""
bday-check-rs "$HOME/Notes/obsidian/vault1/Birthday List.md" 20 | lolcat -f | boxes -t 4 -d info
todo-checker "$HOME/Notes/obsidian/vault1/" | lolcat -f | boxes -t 4 -d info
