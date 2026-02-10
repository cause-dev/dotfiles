#!/usr/bin/env bash
set -euo pipefail

echo "🚀 [3/6] Pulling Dotfiles..."

# Use the chezmoi we just installed via mise
export PATH="$HOME/.local/bin:$PATH"

# Replace with your repo URL
DOTFILES_REPO="https://github.com/YOUR_USERNAME/dotfiles.git"

if ! chezmoi source-path >/dev/null 2>&1; then
    chezmoi init --apply "$DOTFILES_REPO"
else
    chezmoi apply
fi
