#!/bin/bash

MAX_SIZE=50000000  # 50MB in bytes

# Find files that are small enough
# small_files=$(find . -type f -size -"$MAX_SIZE"c ! -path "./.git/*")
# echo "$small_files"


# Stage only small files
# git add $small_files

# Commit and push
# git commit -m "Auto-commit small files"
# git push origin main



is_small_enough() {
    local file="$1"
    local size=$(stat --format="%s" "$file")
    if [ "$size" -le "$MAX_SIZE" ]; then
        return 0  # file is small enough
    else
        return 1  # file is too large
    fi
}

for file in $(find . -type f); do
    if is_small_enough "$file"; then
        echo "Committing small file: $file"
        git add "$file"
    else
        echo "Skipping large file: $file"
    fi
done

git commit -m "Add all small files"

git push
