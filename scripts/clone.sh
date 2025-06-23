#!/bin/bash

cd ~/Github || exit
read -p "repo url: " repo_url
git clone "$repo_url"
