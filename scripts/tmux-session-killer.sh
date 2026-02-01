#!/usr/bin/env bash

sessions=$(tmux list-sessions -F '#S' 2>/dev/null)

if [[ -z $sessions ]]; then
    echo "No active tmux sessions"
    exit 0
fi

selected=$(echo "$sessions" | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

tmux kill-session -t "$selected"
