### 1. PATH SETUP ###
# Use fish_add_path: it is smart, prevents duplicates, and handles missing dirs
fish_add_path $HOME/.local/bin

### 2. INTERACTIVE SESSIONS ###
if status is-interactive

    # --- Aliases ---
    
    alias code="flatpak run com.visualstudio.code" 

    # VPN Management
    alias startRiseUpVPN="sudo systemctl start openvpn-client@riseup"
    alias stopRiseUpVPN="sudo systemctl stop openvpn-client@riseup"
    alias restartRiseUpVPN="sudo systemctl restart openvpn-client@riseup"
    alias updateRiseUpVpnConf="sudo ~/.local/bin/riseup-vpn-configurator --update"
    alias changeRiseUpVpnServer="sudo vi /etc/riseup-vpn.yaml"
    alias generateRiseUpVpnConfig="sudo ~/.local/bin/riseup-vpn-configurator --generate-config"
    
    # Modern CLI replacements
    alias ls="lsd"
    alias ll="lsd -l"
    alias cat="bat"
    alias lg="lazygit"

     # --- Tool Initializations ---

    # Initialize mise (manages your tool versions)
    # We use 'type -q' to check if it exists before running to avoid errors
    if type -q mise
        mise activate fish | source
    end

    # Initialize Starship (The prompt)
    if type -q starship
        starship init fish | source
    end

end
