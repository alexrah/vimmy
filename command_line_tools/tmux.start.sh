#!/bin/sh 
export PATH=$PATH:/usr/local/bin

# abort if we're already inside a TMUX session
[ "$TMUX" == "" ] || exit 0 

# startup a "default" session if none currently exists
tmux has-session -t _default || tmux new-session -s _default -d

# present menu for user to choose which workspace to open
PS3="Please choose your session: "
options=($(tmux list-sessions -F "#S") "NEW SESSION" "NO TMUX" "NEW SSH SESSION")
echo "Available sessions"
echo "------------------"
echo " "
select opt in "${options[@]}"
do
    case $opt in
        "NEW SESSION")
            read -p "Enter new session name: " SESSION_NAME
            tmux new -s "$SESSION_NAME"
            break
            ;;
        "NO TMUX")
            zsh 
            break;;
        *) 
            tmux attach-session -t $opt 
            break
            ;; 
         "NEW SSH SESSION")
            read -p "Enter new session name: " SESSION_NAME
            # read -p "Enter server username: " SERVER_NAME
            # read -p "Enter server address: " SERVER_ADDRESS
            tmux new -s "$SESSION_NAME"
            # ssh $SERVER_NAME@$SERVER_ADDRESS
            break
            ;;

    esac
done  
