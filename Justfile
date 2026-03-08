set shell := ["/usr/bin/bash", "-c"]

# RUN THIS AFTER FIRST BOOT
setup: install-mise install-fonts install-flatpaks
       @echo "🚀 Environment setup complete!"
       @echo "💡 Tip: Restart your terminal to activate mise."

# install or update mise-en-place and all the packages
install-mise:
    @echo "📦 Installing mise..."
    curl https://mise.run | sh
    ~/.local/bin/mise install -y

# install nerd font
install-fonts:
    @echo "🖌️ Checking for Adwaita Mono Nerd Font..."
    @if [ ! -d "$HOME/.local/share/fonts/AdwaitaMono" ]; then \
        echo "📥 Downloading official v3.4.0 archive..."; \
        mkdir -p "$HOME/.local/share/fonts/AdwaitaMono"; \
        curl -fLo /tmp/AdwaitaMono.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/AdwaitaMono.tar.xz; \
        echo "📦 Extracting to ~/.local/share/fonts/AdwaitaMono..."; \
        tar -xJf /tmp/AdwaitaMono.tar.xz -C "$HOME/.local/share/fonts/AdwaitaMono"; \
        rm /tmp/AdwaitaMono.tar.xz; \
        echo "🔄 Refreshing font cache..."; \
        fc-cache -f "$HOME/.local/share/fonts"; \
        echo "✅ Adwaita Mono Nerd Font family installed!"; \
    else \
        echo "✨ Font family already exists, skipping."; \
    fi


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
    dconf dump / > ~/.config/dconf/settings.ini
    chezmoi re-add ~/.config/dconf/settings.ini
    @echo "✅ Settings synced. Ready to 'git push'."

# Manually re-apply GNOME settings from dotfiles
dload:
    @echo "🎨 Loading GNOME settings from dotfiles..."
    dconf load -f / < ~/.config/dconf/settings.ini
