#!/bin/bash

base_dir=$(pwd)
failed_file="$base_dir/failed"

if [ -f "$failed_file" ]; then
    echo "Processing previously failed repositories..."
    while read -r failed_repo; do
        if [ -d "$failed_repo" ]; then
            echo "Retrying repository: $failed_repo"
            cd "$failed_repo" || continue

            git commit --amend --no-edit
            if git push -f origin master; then
                echo "Retry successful: $failed_repo"
            else
                echo "Retry failed: $failed_repo"
                echo "$failed_repo" >> "$base_dir/temp_failed"
            fi
        fi
    done < "$failed_file"
    rm -f "$failed_file"
fi

mv "$base_dir/temp_failed" "$failed_file" 2>/dev/null || rm -f "$failed_file"
cd "$base_dir"
echo "All failed repositories have been processed."