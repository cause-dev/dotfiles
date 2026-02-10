# Justfile - The Orchestrator Dashboard
# Logic is stored in ./scripts/, this file provides the interface.

# Sync everything to match the repository state
sync: system tools apps desktop completions

# --- [ 01 SYSTEM ] ---
# Update OS and layer essential packages
system:
    sudo ./scripts/01-system.sh

# Update the whole system
update:
    ./scripts/update.sh

# --- [ 04 MISE TOOLS ] ---
# Install/Update CLI tools from ~/.config/mise/config.toml
tools:
    ./scripts/04-mise-install.sh

# --- [ 05 FLATPAKS ] ---
# Install/Update GUI apps from packages/flatpaks.txt
apps:
    ./scripts/05-flatpaks.sh

# --- [ 06 DESKTOP ] ---
# Apply GNOME settings from the dconf dump
desktop:
    ./scripts/06-desktop.sh

# --- [ MAINTENANCE & UTILS ] ---

# Update dotfiles manually (Calls script 03)
update-configs:
    ./scripts/03-dotfiles.sh

# Save current GNOME settings (The one logic piece kept here for convenience)
dump-settings:
    @echo "💾 Saving GNOME settings..."
    mkdir -p ~/.config/dconf
    dconf dump / > ~/.config/dconf/gnome_settings.dconf
    @echo "✅ Saved. Now run: chezmoi add ~/.config/dconf/gnome_settings.dconf"

# Update fish completions
completions:
    @echo "🐚 Updating fish completions..."
    fish -c "fish_update_completions"

# Deep clean system
cleanup:
    @echo "🧹 Cleaning system..."
    rpm-ostree cleanup -m
    flatpak uninstall --unused -y
    mise prune -y