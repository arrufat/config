function setup_gnome_keybindings
    set wm_keybindings org.gnome.desktop.wm.keybindings
    set gs_keybindings org.gnome.shell.keybindings
    gsettings set $wm_keybindings close "['<Alt>F4', '<Super>c']"
    gsettings set $wm_keybindings begin-resize "['<Alt>F8', '<Super>r']"
    gsettings set $wm_keybindings toggle-fullscreen "['<Super>f']"
    gsettings set $wm_keybindings switch-to-workspace-1 "['<Super>Home', '<Super>1']"
    gsettings set $gs_keybindings switch-to-application-1 "[]"
    gsettings set $wm_keybindings move-to-workspace-1 "['<Super><Shift>Home', '<Shift><Super>1']"
    for i in (seq 2 9)
        gsettings set $wm_keybindings switch-to-workspace-$i "['<Super>$i']"
        gsettings set $wm_keybindings move-to-workspace-$i "['<Shift><Super>$i']"
        gsettings set $gs_keybindings switch-to-application-$i "[]"
    end

    # Custom Keybindings
    set -l schema "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"
    set -l base "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

    # Add custom paths to the list if missing
    set -l current_list (gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
    for i in (seq 0 6)
        set -l path "$base/custom$i/"
        if not string match -q "*$path*" "$current_list"
            set current_list (string replace "]" ", '$path']" "$current_list" | string replace "[, " "[")
            gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$current_list"
        end
    end

    # Terminal
    gsettings set "$schema:$base/custom0/" name "Terminal"
    gsettings set "$schema:$base/custom0/" command "foot"
    gsettings set "$schema:$base/custom0/" binding "<Super>Return"

    # System Monitor
    gsettings set "$schema:$base/custom1/" name "System Monitor"
    gsettings set "$schema:$base/custom1/" command "gnome-system-monitor"
    gsettings set "$schema:$base/custom1/" binding "<Control>Escape"

    # Enpass
    gsettings set "$schema:$base/custom2/" name "Enpass"
    gsettings set "$schema:$base/custom2/" command "/opt/enpass/Enpass showassistant"
    gsettings set "$schema:$base/custom2/" binding "<Super>e"

    # TClip
    gsettings set "$schema:$base/custom3/" name "Translate selection"
    gsettings set "$schema:$base/custom3/" command "/home/adria/Projects/tclip/tclip"
    gsettings set "$schema:$base/custom3/" binding "<Super>t"

    gsettings set "$schema:$base/custom4/" name "Translate selection LLM"
    gsettings set "$schema:$base/custom4/" command "/home/adria/Projects/tclip/tclip -llm"
    gsettings set "$schema:$base/custom4/" binding "<Control><Super>t"

    gsettings set "$schema:$base/custom5/" name "Translate selection append"
    gsettings set "$schema:$base/custom5/" command "/home/adria/Projects/tclip/tclip -sep '>'"
    gsettings set "$schema:$base/custom5/" binding "<Shift><Super>t"

    gsettings set "$schema:$base/custom6/" name "Translate selection LLM append"
    gsettings set "$schema:$base/custom6/" command "/home/adria/Projects/tclip/tclip -llm -sep '>'"
    gsettings set "$schema:$base/custom6/" binding "<Shift><Control><Super>t"
end
