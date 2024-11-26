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
end
