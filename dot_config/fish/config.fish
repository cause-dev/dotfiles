### 1. PATH SETUP ###
# Use fish_add_path: it is smart, prevents duplicates, and handles missing dirs
fish_add_path $HOME/.local/bin

### 2. INTERACTIVE SESSIONS ###
if status is-interactive

    # --- Aliases ---
    
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

end
