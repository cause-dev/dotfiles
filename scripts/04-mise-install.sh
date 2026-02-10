#!/usr/bin/env bash
set -euo pipefail
echo "🔧 [4/6] Installing Tools from mise config..."

# Ensure mise is in path for this sub-shell
export PATH="$HOME/.local/bin:$PATH"

# This reads ~/.config/mise/config.toml (pulled in step 03)
if [ -f "$HOME/.config/mise/config.toml" ]; then
    mise install
    echo "✅ Mise tools installed."
else
    echo "⚠️ No mise config found. Skipping tool installation."
fi