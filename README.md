# 🌌 Personal Fedora Atomic Dotfiles

This repository contains the **"Soul"** of my workstation. It is designed to be paired with my [Custom Fedora Bootc Image](https://github.com/cause-dev/fedora-bootc) to provide a 100% reproducible, zero-touch desktop environment.

## 🏗️ The Philosophy
*   **The House (OS):** Built via `bootc` and `dnf`. It handles the Kernel, GNOME, Drivers, and core CLI tools (`fish`, `just`, `chezmoi`).
*   **The Furniture (Dotfiles):** Managed by `chezmoi`. It handles SSH keys, shell aliases, and GNOME settings.
*   **The Workbench (Environment):** Managed by `just` and `mise`. It handles Flatpaks and development runtimes (Node, Python, etc.).

---

## 🚀 Quick Start (New Machine)

Once you have installed the [Custom OS Image](https://github.com/cause-dev/fedora-bootc), run the following command to bootstrap your entire environment:

```bash
# 1. Initialize Dotfiles
chezmoi init --apply https://github.com/cause-dev/dotfiles

# 2. Build the Environment
just setup
```

---

## 🛠️ Toolstack
| Tool | Purpose |
| :--- | :--- |
| **[bootc](https://containers.github.io/bootc/)** | Transactional, image-based OS updates. |
| **[chezmoi](https://www.chezmoi.io/)** | Secure and reproducible dotfile management. |
| **[just](https://github.com/casey/just)** | Command runner for environment orchestration. |
| **[fish](https://fishshell.com/)** | User-friendly, interactive command line. |
| **[mise](https://mise.jdx.dev/)** | Polyglot runtime manager (replacing nvm, pyenv, etc.). |
| **[Flatpak](https://flatpak.org/)** | Decoupled graphical application management. |

---

## 🍱 Justfile Recipes

The `justfile` is the central entry point for maintaining the system.

### Initial Setup
- `just setup`: Runs the full bootstrap (installs `mise` and all `Flatpaks`).
- `just install-mise`: Only installs/updates the `mise` binary.
- `just install-flatpaks`: Installs the curated list of GUI applications.

### Maintenance
- `just update`: The "Master Update" command. Upgrades the **OS Image**, **Flatpaks**, **Mise runtimes**, and **Dotfiles**.

### GNOME Settings
- `just dsync`: Dumps current GNOME settings (shortcuts, theme, etc.) and syncs them to the dotfiles repo.
- `just dload`: Manually forces a reload of settings from the dotfiles into the OS.

---

## 🎨 GNOME Configuration
GNOME settings are managed via `dconf` dumps stored in `dot_config/dconf/settings.ini`.

**To update your settings in Git:**
1. Change your shortcuts/settings in the GNOME Settings app.
2. Run `just dsync`.
3. Commit and push the changes.

The settings are applied **automatically** on new installations via a `run_once_after_` script managed by chezmoi.

---

## 📂 Structure
```text
.
├── dot_config/
│   ├── dconf/           # GNOME settings dumps (.ini)
│   ├── fish/            # Fish shell configuration
│   └── mise/            # Mise global config and tool-versions
├── .chezmoiscripts/     # Automated setup scripts (GNOME setup, etc.)
├── Justfile             # Task orchestration
└── README.md
```

---

## 📜 License
MIT © [cause-dev]