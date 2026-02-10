#!/usr/bin/env bash
set -euo pipefail

echo "📦 [5/6] Installing Flatpaks..."

# Ensure Flathub is enabled
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install from our modular list
if [ -f "packages/flatpak/install.txt" ]; then
    cat packages/flatpak/install.txt | xargs -r flatpak install -y flathub
fi