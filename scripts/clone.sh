#!/bin/bash

cd ~/Github || exit
read -p "repo url: " repo_url
git clone "$repo_url"
repo_name=$(basename "$repo_url" .git)
tmux switch-client -t "$repo_name" && exit
