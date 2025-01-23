#!/bin/bash

base_dir=$(pwd)
failed_file="$base_dir/failed"

find "$base_dir" -type d -name ".git" | while read -r git_dir; do
    repo_dir=$(dirname "$git_dir")
    echo "Processing repository: $repo_dir"

    cd "$repo_dir" || continue

    dir_name=$(basename "$repo_dir")g

    user_name=$(git config --local user.name)
    if [ -z "$user_name" ] || [ "$user_name" != [GITLAB_NAME] ]; then
        git config --local [GITLAB_NAME]
    fi

    user_email=$(git config --local user.email)
    if [ -z "$user_email" ] || [ "$user_email" != [GITLAB_EMAIL] ]; then
        git config --local user.email [GITLAB_EMAIL]
    fi

    find "$repo_dir" -type f -name "*.java" | while read -r java_file; do
        file_name=$(basename "$java_file")

        if git diff --quiet "$java_file"; then
            continue
        fi

        commit_message="add: solution for $dir_name"

        echo "Processing: $file_name"
        git add "$java_file"
        echo "Added: $file_name"

        git commit -m "$commit_message"
        echo "Committed: $file_name with message: $commit_message"

        if ! git push origin master; then
            echo "$repo_dir" >> "$failed_file"
            echo "Failed to push: $repo_dir"
        else
            echo "Pushed: $file_name to remote"
        fi
        echo "-------------------------------"
    done

echo "Finished processing repository: $repo_dir"

done

cd "$base_dir"
echo "All repositories have been processed."