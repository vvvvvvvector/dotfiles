#!/bin/bash

SESSION="ghostty"

tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
   tmux new -d -s $SESSION -n "work"
   tmux send-keys -t 'work' "cd ~/Work" C-m 

   tmux new-window -t $SESSION:2 -n "tmp_1"
   tmux send-keys -t "tmp_1" "cd /tmp" C-m 

   tmux new-window -t $SESSION:3 -n "tmp_2"
   tmux send-keys -t "tmp_2" "cd /tmp" C-m 
fi

tmux attach-session -t $SESSION:1
