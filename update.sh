#!/bin/bash

base_dir=$(pwd)

find "$base_dir" -type d -name ".git" | while read -r git_dir; do
    repo_dir=$(dirname "$git_dir")
    echo "Updating repository: $repo_dir"

    cd "$repo_dir" || continue

    dir_name=$(basename "$repo_dir")

    user_name=$(git config --local user.name)
    if [ -z "$user_name" ] || [ "$user_name" != [GITLAB_NAME] ]; then
        git config --local user.name [GITLAB_NAME]
    fi

    user_email=$(git config --local user.email)
    if [ -z "$user_email" ] || [ "$user_email" != [GITLAB_EMAIL] ]; then
        git config --local user.email [GITLAB_EMAIL]
    fi

    git fetch 
    git pull 2> /dev/null

echo "Repository Updated: $repo_dir"

done

cd "$base_dir"
echo "All repositories have been Updated."