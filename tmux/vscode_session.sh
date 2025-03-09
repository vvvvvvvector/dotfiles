#!/bin/bash

SESSION="vscode"

tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
   tmux new -d -s $SESSION
   tmux split-window -h
   tmux split-window -v
   tmux select-pane -t 1

   tmux new-window -t $SESSION:2 -n "dev"

   tmux new-window -t $SESSION:3 -n "studio"
fi

tmux attach-session -t $SESSION:1
