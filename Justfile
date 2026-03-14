set shell := ["/usr/bin/bash", "-c"]

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
        com.github.tchx84.Flatseal \
        io.mpv.Mpv \
        org.gnome.NautilusPreviewer \
        org.gnome.Papers \
        org.gnome.TextEditor
    flatpak update -y

# Update the whole system
update:
    @echo "🔄 Updating OS Image..."
    rpm-ostree upgrade
    @echo "🔄 Updating Flatpaks..."
    flatpak update -y
    @echo "🔄 Updating mise runtimes..."
    mise self-update -y
    @echo "🔄 Updating mise packages..."
    mise upgrade
