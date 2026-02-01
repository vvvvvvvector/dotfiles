#!/usr/bin/env bash

# if number of arguments ($#) == 1; argument - session name
# else - interactive selection
if [[ $# -eq 1 ]]; then
    selected=$1
else
    # store result of the selection in selected variable
    selected=$(
        { find ~/Github ~/Work/ -mindepth 1 -maxdepth 1 -type d; echo /tmp; } | \
        sed "s|^$HOME/||" | \
        fzf
    )
    # if selected variable is not empty (string is not empty -n; string length > 0)
    if [[ -n "$selected" && "$selected" != /* ]]; then
        selected="$HOME/$selected"
    fi
    # ^^^ Add home path back ^^^
fi

# if selected variable is empty (string is empty -z; string length == 0)
if [[ -z $selected ]]; then
   exit 0 # terminate the script
fi

selected_name=$(basename "$selected" | tr . _) # a name for tmux session; extracts file or directory name and replace . with _
tmux_running=$(pgrep tmux) # store tmux proccess id

# if not inside tmux session and tmux process is not running
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

# if not inside tmux session and tmux process is running
if [[ -z $TMUX ]] && [[ -n $tmux_running ]]; then
    if ! tmux has-session -t="$selected_name" 2> /dev/null; then
        tmux new-session -ds "$selected_name" -c "$selected"
    fi
    tmux attach-session -t "$selected_name"
    exit 0
fi

# if tmux session with "selected_name" doesn't exist
if ! tmux has-session -t="$selected_name" 2> /dev/null; then
    # -c "$select" - starting directory for the session
    tmux new-session -ds "$selected_name" -c "$selected" 
    # select first window
    tmux select-window -t "$selected_name":1
fi

tmux switch-client -t "$selected_name"
