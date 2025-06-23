#!/bin/bash

dir=~/Github

cd "$dir" || exit

while true; do
  read -p "repo url: " repo_url

  if [[ -z "$repo_url" ]]; then
    echo "url cannot be empty. please try again"
  elif ! [[ "$repo_url" =~ ^(https://|git@) ]]; then
    echo "invalid url format. please enter a valid git url"
  else
    break
  fi
done

repo_name=$(basename "$repo_url" .git)

git clone "$repo_url"

repo_dir="$dir/$repo_name"

if [[ -z $TMUX ]] && [[ -z $(pgrep tmux) ]]; then
    tmux new-session -s "$repo_name" -c "$repo_dir"
    exit 0
fi

if ! tmux has-session -t="$repo_name" 2> /dev/null; then
    tmux new-session -ds "$repo_name" -c "$repo_dir" 
    tmux select-window -t "$repo_name":1
fi

tmux switch-client -t "$repo_name"
