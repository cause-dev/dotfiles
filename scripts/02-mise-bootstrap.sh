#!/usr/bin/env bash
set -euo pipefail
echo "🛠️ [2/6] Bootstrapping Mise..."

if ! command -v mise &> /dev/null; then
    curl -fsSL https://mise.run | sh
fi

export PATH="$HOME/.local/bin:$PATH"
# Use mise to get the tools needed for the next steps
mise use -g chezmoi
