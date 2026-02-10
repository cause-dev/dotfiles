#!/usr/bin/env bash
set -euo pipefail
echo "🎨 [6/6] Applying Desktop Settings (dconf)..."

DCONF_FILE="$HOME/.config/dconf/gnome_settings.dconf"

if [ -f "$DCONF_FILE" ]; then
    dconf load / < "$DCONF_FILE"
    echo "✅ GNOME settings applied."
else
    echo "⚠️ No dconf file found at $DCONF_FILE. Skipping."
fi