#!/usr/bin/env bash
# Main Orchestrator
set -euo pipefail

ACTUAL_USER=${SUDO_USER:-$USER}
USER_HOME=$(getent passwd "$ACTUAL_USER" | cut -d: -f6)

echo "🚀 Starting Modular Fedora Silverblue Setup..."

# Step 1: System (Requires Sudo)
# This handles: Upgrades, Overrides, and Layering
sudo ./scripts/01-system.sh

# Steps 2-6: User Space (No Sudo)
# Executed as the actual user to ensure correct file ownership
sudo -u "$ACTUAL_USER" bash <<EOF
    export PATH="$USER_HOME/.local/bin:\$PATH"
    export HOME="$USER_HOME"

    ./scripts/02-mise-bootstrap.sh  # Installs mise/chezmoi
    ./scripts/03-dotfiles.sh        # Pulls your repo
    ./scripts/04-mise-install.sh    # Installs starship/bat/lsd
    ./scripts/05-flatpaks.sh        # Installs GUI apps
    ./scripts/06-desktop.sh         # Applies dconf/GNOME settings
EOF

echo ""
echo "✨ Setup fully complete!"
echo "🔄 A reboot is recommended to boot into the updated deployment."

read -p "Reboot now? [y/N] " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then reboot; fi
