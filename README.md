### Setup Host System
```bash
rpm-ostree upgrade
rpm-ostree install android-tools distrobox fish
hostnamectl set-hostname xyz
systemctl reboot
```
### Change default shell
```bash
chsh -s $(which fish)
```

### Install and activate mise-en-place
```bash
curl https://mise.run | sh
echo '~/.local/bin/mise activate fish | source' >> ~/.config/fish/config.fish
```

### Apply dotfiles using Chezmoi
```bash
mise use -g chezmoi
chezmoi init --apply "https://github.com/cause-dev/dotfiles"
mise install
```

### Install Graphical Applications
```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.bitwarden.desktop \
						   com.github.neithern.g4music \
						   com.github.tchx84.Flatseal \
						   com.mattjakeman.ExtensionManager \
						   com.protonvpn.www \
						   com.ranfdev.DistroShelf \
						   com.visualstudio.code \
						   de.haeckerfelix.Fragments \
						   dev.vencord.Vesktop \
						   io.github.flattool.Warehouse \
						   io.github.giantpinkrobots.varia \
						   io.podman_desktop.PodmanDesktop \
						   md.obsidian.Obsidian \
						   org.chromium.Chromium \
						   org.cryptomator.Cryptomator \
						   org.gnome.DejaDup \
						   org.gnome.FileRoller \
						   org.mozilla.firefox \
						   org.signal.Signal \
						   org.telegram.desktop
flatpak update -y
```

### Load dconf settings
```bash
dconf load / < "$HOME/.config/dconf/gnome_settings.dconf"
```

### Override default packages
```bash
rpm-ostree override remove firefox firefox-langpacks gnome-software gnome-software-rpm-ostree PackageKit-glib
```
