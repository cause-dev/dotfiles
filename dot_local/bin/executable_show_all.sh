#!/usr/bin/env bash

EXCLUDE_DIRS=(".git" "node_modules")
EXCLUDE_FILES=("*.log" "*.bin" "LICENSE" "cosign.pub" ".gitignore")

echo "===== DIRECTORY TREE ====="
tree -a -I "$(IFS="|"; echo "${EXCLUDE_DIRS[*]}")"

echo -e "\n===== FILE CONTENTS ====="

# Build find command safely using arrays
find_cmd=(find .)

# Directory pruning
find_cmd+=(
  \( -type d
)

for dir in "${EXCLUDE_DIRS[@]}"; do
  find_cmd+=( -name "$dir" -o )
done
unset 'find_cmd[${#find_cmd[@]}-1]'  # remove last -o

find_cmd+=(
  \) -prune -o \( -type f
)

# File exclusions
for pattern in "${EXCLUDE_FILES[@]}"; do
  find_cmd+=( ! -name "$pattern" )
done

# Actions
find_cmd+=(
  -exec printf "\n--- %s ---\n" {} \;
  -exec cat {} \;
  \)
)

# Execute
"${find_cmd[@]}"
