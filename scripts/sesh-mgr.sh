#!/usr/bin/env bash

SESSION=""
TARGET_WINDOW=1

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "[Err]: available params: | --base | --vscode | --dev [<target_window>]"
    exit 1
fi

case $1 in
    --base)
        SESSION="base"
        ;;
    --vscode)
        SESSION="vscode"
        ;;
    --dev)
        SESSION="dev"
        ;;
    *)
        echo "Invalid option: $1"
        exit 1
        ;;
esac


if [ "$#" -eq 2 ]; then
    TARGET_WINDOW=$2
fi

tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
    case $SESSION in
        base)
            tmux new -d -s $SESSION -n "work"
            tmux send-keys -t 'work' "cd ~/Work" C-m "clear" C-m

            tmux new-window -t $SESSION:2 -n "tmp"
            tmux send-keys -t "tmp" "cd /tmp" C-m "clear" C-m

            ;;
        vscode)
            tmux new -d -s $SESSION
            tmux split-window -h
            tmux split-window -v
            tmux select-pane -t 1

            tmux new-window -t $SESSION:2 -n "dev"

            tmux new-window -t $SESSION:3 -n "studio"

            tmux new-window -t $SESSION:4 -n "lazygit"
            tmux send-keys -t "lazygit" "lg" C-m 

            ;;
        dev)
            tmux new -d -s $SESSION -n "nvim"
            tmux send-keys -t "nvim" "nvim ." C-m 

            tmux new-window -t $SESSION:2 -n "dev"
            tmux split-window -h

            tmux new-window -t $SESSION:3 -n "git"

            ;;
    esac
fi

tmux attach-session -t $SESSION:$TARGET_WINDOW
