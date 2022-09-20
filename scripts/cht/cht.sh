#!/usr/bin/env bash
selected=$(cat ~/.config/scripts/cht/cht-languages ~/.config/scripts/cht/cht-command | fzf)
if [[ -z $selected ]]; then
    exit 0
fi

read -r -p "Enter Query: " query

if grep -qs "$selected" ~/.config/scripts/cht/cht-languages; then
    query=$(echo "$query" | tr ' ' '+') 
    curl -s cht.sh/"$selected"/"$query" | less
else
    curl -s cht.sh/"$selected"/"$query" | less
fi


#########################################################################################################
# credit ThePrimeagen

# #!/usr/bin/env bash
# selected=`cat ~/.tmux-cht-languages ~/.tmux-cht-command | fzf`
# if [[ -z $selected ]]; then
#     exit 0
# fi
#
# read -p "Enter Query: " query
#
# if grep -qs "$selected" ~/.tmux-cht-languages; then
#     query=`echo $query | tr ' ' '+'`
#     tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
# else
#     tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
# fi
