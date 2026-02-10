#!/usr/bin/env bash
set -euo pipefail

echo "🛡️ [1/6] Updating and Applying System Layer..."

# 1. Update the base system first
echo "🔄 Checking for system upgrades..."
rpm-ostree upgrade

# 2. Handle Overrides (Removing base packages)
if [ -f "packages/rpm/uninstall.txt" ]; then
    echo "🗑️ Removing base packages..."
    xargs -a packages/rpm/uninstall.txt rpm-ostree override remove
fi

# 3. Handle Essential Layers
if [ -f "packages/rpm/install.txt" ]; then
    echo "📦 Layering packages with --apply-live..."
    xargs -a packages/rpm/install.txt rpm-ostree install --apply-live --allow-inactive
fi