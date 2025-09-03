{
    config,
    pkgs,
    lib,
    ...
}: {
    home-manager.users.soma.wayland.windowManager.sway = {
        enable = true;
        extraConfig = "exec autotiling-rs
    exec wlsunset -t 3500 -l 47.5 -L 19
    exec mako
    exec swayosd-server
    exec swaybg -m fill -i /home/soma/dx/nixos/misc/wallpaper.jpg
    bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindsym XF86AudioRaiseVolume exec swayosd-client --output-volume raise --max-volume 100
    bindsym XF86AudioLowerVolume exec swayosd-client --output-volume lower --max-volume 100
    bindsym XF86MonBrightnessDown exec brightnessctl set 5%-
    bindsym XF86MonBrightnessUp exec brightnessctl set 5%+
    bindsym --release Super_L exec wmenu-run";
        wrapperFeatures.gtk = true;
        config = {
            output = {
                DSI-1 = {
                    transform = "90";
                    scale = "1.5";
                };
            };
            modifier = "Mod1";
            terminal = "kitty";
            menu = "wmenu-run";
            defaultWorkspace = "workspace number 1";
            left = "m";
            down = "n";
            up = "e";
            right = "i";
            bindswitches."lid:toggle".action = "exec ${pkgs.swaylock}/bin/swaylock -fFK -s fill -i /home/soma/dx/nixos/misc/wallpaper.jpg";
            bars = [];
            modes = {};
            window = {
                border = 1;
                hideEdgeBorders = "smart_no_gaps";
                titlebar = false;
                commands = [
                    {
                        command = "opacity 0.75";
                        criteria.class = ".*";
                    }
                    {
                        command = "floating enable, move absolute position 540 0, resize set width 300 height 200";
                        criteria.title = "^password$";
                    }
                ];
            };
            focus.followMouse = "always";
            colors = {
                focused = {
                    background = "#ff0000";
                    border = "#ff0000";
                    childBorder = "#ff0000";
                    indicator = "#ff0000";
                    text = "#ff0000";
                };
            };
            input = {
                "type:keyboard" = {
                    xkb_layout = "us,hu";
                    xkb_variant = "colemak_dh,101_qwerty_dot_nodead";
                    xkb_options = "caps:backspace,grp:shifts_toggle";
                };
                "type:touchpad" = {
                    tap = "enabled";
                    dwt = "enabled";
                    natural_scroll = "enabled";
                };
            };
            keybindings = {
                "mod1+Return" = "exec ${pkgs.kitty}/bin/kitty";
                "mod1+c" = "kill";
                "mod1+w" = "exec librewolf";
                "mod1+g" = "exec chromium";
                "mod1+k" = "exec keepassxc /home/soma/dx/Backups/Keepass/keepass.kdbx";
                "mod1+p" = "exec mpv --force-window=immediate $(wl-paste | sed 's|inv.nadeko.net|youtube.com|')";
                "mod1+o" = "exec onlyoffice-desktopeditors";
                "mod1+y" = "exec freetube";
                "mod1+l" = "exec logseq";
                "mod1+s" = "exec fluffychat";
                "mod1+f" = "fullscreen";
                "mod1+BackSpace" = "exec makoctl dismiss";
                "mod1+r" = ''exec sh -c 'nixos_dir=~/dx/nixos ; git -C $nixos_dir diff --quiet "*.nix" && return 1 ; alejandra --experimental-config /home/soma/dx/nixos/misc/alejandra.toml --quiet $nixos_dir ; notify-send -e -t 5000 "NixOS Rebuilding..." ; doas nice -n 19 nixos-rebuild switch &> $nixos_dir/misc/nixos-switch.log && generation=$(git -C $nixos_dir diff -U20 HEAD | aichat summarizewhat changed in my nixos config in one short sentence) && git -C $nixos_dir commit -q -am "$generation" && git -C $nixos_dir push -q -u origin main && notify-send -e -t 5000 "Rebuild successful" || notify-send -e -t 5000 "Rebuild Failed" && return 1 '  '';
                "mod1+h" = ''exec kitty -T password sh -c 'read -s -p "Enter password: " password ; entry=$( echo -e "$password\n" |  keepassxc-cli ls dx/Backups/Keepass/keepass.kdbx -q | fzf ) ; [[ -n "$entry" ]] && nohup librewolf --new-tab $( echo -e "$password\n" | keepassxc-cli show -q -a URL dx/Backups/Keepass/keepass.kdbx "$entry" ) &> /dev/null & echo -e "$password\n" |  keepassxc-cli show dx/Backups/Keepass/keepass.kdbx "$entry" -q -a UserName | wl-copy ; watch "echo Username copied" ; echo -e "$password\n" |  keepassxc-cli show dx/Backups/Keepass/keepass.kdbx "$entry" -q -a Password | wl-copy ; watch "echo Password copied" ; echo -e "$password\n" |  keepassxc-cli show dx/Backups/Keepass/keepass.kdbx "$entry" -q -t | wl-copy ; [[ -n "$(wl-paste)" ]] && watch "echo TOTP copied" ; wl-copy -c' '';
                "Print" = "exec grim -g \"$(slurp)\"";

                "mod1+m" = "focus left";
                "mod1+n" = "focus down";
                "mod1+e" = "focus up";
                "mod1+i" = "focus right";

                "mod1+Shift+m" = "move left";
                "mod1+Shift+n" = "move down";
                "mod1+Shift+e" = "move up";
                "mod1+Shift+i" = "move right";

                "mod1+1" = "workspace number 1";
                "mod1+2" = "workspace number 2";
                "mod1+3" = "workspace number 3";
                "mod1+4" = "workspace number 4";
                "mod1+5" = "workspace number 5";
                "mod1+6" = "workspace number 6";
                "mod1+Tab" = "workspace back_and_forth";

                "mod1+Shift+1" = "move container to workspace number 1";
                "mod1+Shift+2" = "move container to workspace number 2";
                "mod1+Shift+3" = "move container to workspace number 3";
                "mod1+Shift+4" = "move container to workspace number 4";
                "mod1+Shift+5" = "move container to workspace number 5";
                "mod1+Shift+6" = "move container to workspace number 6";
                "mod1+Shift+q" = "swaymsg exit";

                "mod1+f1" = "exec doas ${pkgs.kbd}/bin/chvt 1";
                "mod1+f2" = "exec doas ${pkgs.kbd}/bin/chvt 2";
                "mod1+f3" = "exec doas ${pkgs.kbd}/bin/chvt 3";
                "mod1+f4" = "exec doas ${pkgs.kbd}/bin/chvt 4";
                "mod1+f5" = "exec doas ${pkgs.kbd}/bin/chvt 5";
                "mod1+f6" = "exec doas ${pkgs.kbd}/bin/chvt 6";
            };
        };
    };
    home-manager.users.soma.services.swayosd.enable = true;
    home-manager.users.soma.services.swayidle = {
        enable = true;
        timeouts = [
            {
                timeout = 600;
                command = "${pkgs.swaylock}/bin/swaylock -fFK -s fill-i /home/soma/dx/nixos/misc/wallpaper.jpg ; [ $(cat /sys/class/power_supply/BAT0/status) = Discharging ] && systemctl suspend-then-hibernate";
            }
        ];
    };
}
