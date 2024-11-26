function setup_gnome_keybindings
    set keybindings org.gnome.desktop.wm.keybindings
    gsettings set $keybindings close "['<Alt>F4', '<Super>c']"
    gsettings set $keybindings begin-resize "['<Alt>F8', '<Super>r']"
    gsettings set $keybindings toggle-fullscreen "['<Super>f']"
    gsettings set $keybindings switch-to-workspace-1 "['<Super>Home', '<Super>1']"
    gsettings set $keybindings move-to-workspace-1 "['<Super><Shift>Home', '<Shift><Super>1']"
    for i in (seq 2 9)
        gsettings set $keybindings switch-to-workspace-$i "['<Super>$i']"
        gsettings set $keybindings move-to-workspace-$i "['<Shift><Super>$i']"
    end
end
