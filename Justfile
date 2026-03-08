set shell := ["/usr/bin/fish", "-c"]

# RUN THIS AFTER FIRST BOOT
setup: install-mise install-flatpaks
       @echo "🚀 Environment setup complete!"
       @echo "💡 Tip: Restart your terminal to activate mise."

# install or update mise-en-place and all the packages
install-mise:
    @echo "📦 Installing mise..."
    curl https://mise.run | sh
    ~/.local/bin/mise install -y


# Install all the flatpaks
install-flatpaks:
    @echo "📥 Installing Flatpaks..."
    flatpak install -y flathub \
        com.github.neithern.g4music \
        com.mattjakeman.ExtensionManager \
        com.protonvpn.www \
        com.ranfdev.DistroShelf \
        de.haeckerfelix.Fragments \
        dev.vencord.Vesktop \
        io.github.flattool.Warehouse \
        org.cryptomator.Cryptomator \
        org.gnome.DejaDup \
        org.gnome.FileRoller \
        org.signal.Signal \
        org.telegram.desktop \
        com.visualstudio.code \
        md.obsidian.Obsidian \
        org.mozilla.firefox \
        com.bitwarden.desktop \
        com.github.tchx84.Flatseal
    flatpak update -y

# Update the whole system
update:
    @echo "🔄 Updating OS Image..."
    sudo bootc upgrade
    @echo "🔄 Updating Flatpaks..."
    flatpak update -y
    @echo "🔄 Updating mise runtimes..."
    mise self-update -y
    @echo "🔄 Updating mise packages..."
    mise upgrade

# Sync current GNOME settings back to dotfiles
dsync:
    @echo "🎨 Exporting GNOME settings..."
    dconf dump /org/gnome/ > ~/.config/dconf/settings.ini
    chezmoi re-add ~/.config/dconf/settings.ini
    @echo "✅ Settings synced. Ready to 'git push'."

# Manually re-apply GNOME settings from dotfiles
dload:
    @echo "🎨 Loading GNOME settings from dotfiles..."
    dconf load /org/gnome/ < ~/.config/dconf/settings.ini
