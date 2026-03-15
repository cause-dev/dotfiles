set shell := ["/usr/bin/bash", "-c"]

# RUN THIS AFTER FIRST BOOT
setup: install-mise 
       @echo "🚀 Environment setup complete!"
       @echo "💡 Tip: Restart your terminal to activate mise."

# install or update mise-en-place and all the packages
install-mise:
    @echo "📦 Installing mise..."
    curl https://mise.run | sh
    ~/.local/bin/mise install -y

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
