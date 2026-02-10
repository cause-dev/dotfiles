#!/usr/bin/env bash
set -euo pipefail

echo "🆙 Starting full system update..."

# 1. Update rpm-ostree (System & Layered Packages)
echo "🛡️ Updating rpm-ostree system image..."
rpm-ostree upgrade

# 2. Update Flatpaks
echo "📦 Updating Flatpaks..."
flatpak update -y

# 3. Update mise and its tools
echo "🛠️ Updating mise manager and tools..."
if command -v mise &> /dev/null; then
    # self-update updates the mise binary itself
    mise self-update --yes
    # upgrade updates the tools (bat, lsd, etc.) based on config.toml
    mise upgrade
fi

echo "✅ All components are up to date!"