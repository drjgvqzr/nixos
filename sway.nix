{
    config,
    pkgs,
    lib,
    ...
}: {
    home-manager.users.soma.wayland.windowManager.sway = {
        enable = true;
        extraConfig = ''
            #exec autotiling-rs
            exec mako
            exec papersway
            exec swaybg -m fill -i /home/soma/dx/nixos/misc/wallpaper.jpg
            bindsym XF86AudioMute exec volumectl toggle-mute
            bindsym XF86AudioRaiseVolume exec volumectl -u up
            bindsym XF86AudioLowerVolume exec volumectl -u down
            bindsym XF86MonBrightnessDown exec lightctl down
            bindsym XF86MonBrightnessUp exec lightctl up
            bindsym Pause exec playerctl --player mpv play-pause || playerctl play-pause
            bindsym XF86AudioNext exec playerctl --player mpv next || playerctl next
            bindsym XF86AudioPrev exec playerctl --player mpv previous || playerctl previous
            bindsym --release Super_L exec wmenu-run
            bindgesture swipe:4:up input type:keyboard events toggle'';
        wrapperFeatures.gtk = true;
        config = {
            assigns = {
                "7" = [{app_id = "librewolf";}];
                "8" = [{app_id = "Logseq";}];
                "9" = [{app_id = "fluffychat";}];
                "10" = [{app_id = "org.keepassxc.KeePassXC";}];
                "11" = [{class = "ONLYOFFICE";}];
            };
            output = {
                DSI-1 = {
                    scale = "1.5";
                };
            };
            defaultWorkspace = "workspace number 1";
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
                        #command = "opacity 1.00";
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
                    background = "#aaaaaa";
                    border = "#aaaaaa";
                    childBorder = "#aaaaaa";
                    indicator = "#aaaaaa";
                    text = "#aaaaaa";
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
                "mod1+Return" = "exec foot";
                #"mod1+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
                #"mod1+Return" = "exec ${pkgs.kitty}/bin/kitty";
                "mod1+c" = "kill";
                "mod1+b" = "exec notify-send -e \"$(cat /sys/class/power_supply/BAT0/capacity)%\"";
                "mod1+t" = "exec notify-send -e \"$(date \"+%H:%M\")\"";
                "mod1+p" = "exec mpv --force-window=immediate $(wl-paste | sed 's|inv.nadeko.net|youtube.com|')";
                "mod1+w" = "exec swaymsg '[app_id=\"librewolf\"] focus' || exec librewolf ; exec swaymsg 'workspace number 7'";
                "mod1+l" = "exec swaymsg '[app_id=\"Logseq\"] focus' || exec logseq ; exec swaymsg 'workspace number 8'";
                "mod1+s" = "exec swaymsg '[app_id=\"fluffychat\"] focus' || exec fluffychat ; exec swaymsg 'workspace number 9'";
                "mod1+k" = "exec swaymsg '[app_id=\"org.keepassxc.KeePassXC\"] focus' || exec keepassxc /home/soma/dx/Backups/Keepass/keepass.kdbx ; exec swaymsg 'workspace number 10'";
                "mod1+o" = "exec swaymsg '[class=\"ONLYOFFICE\"] focus' || exec onlyoffice-desktopeditors ; exec swaymsg 'workspace number 11'";
                "mod1+r" = ''exec sh -c 'nixos_dir=~/dx/nixos ; git -C $nixos_dir diff --quiet "*.nix" && notify-send -e -t 5000 "No changes detected, exiting" && exit ; alejandra --experimental-config /home/soma/dx/nixos/misc/alejandra.toml --quiet $nixos_dir ; notify-send -e -t 5000 "NixOS Rebuilding..." ; doas nice -n 19 nixos-rebuild switch &> $nixos_dir/misc/nixos-switch.log && generation=$(git -C $nixos_dir diff -U20 HEAD | aichat summarizewhat changed in my nixos config in one short sentence | sed 's/.$//' ) && git -C $nixos_dir commit -q -am "$generation" && git -C $nixos_dir push -q -u origin main && notify-send -e -t 5000 "Rebuild successful" || notify-send -e -t 5000 "Rebuild Failed" && exit '  '';
                "mod1+h" = ''exec foot -T password sh -c 'read -s -p "Enter password: " password ; entry=$( echo -e "$password\n" |  keepassxc-cli ls dx/Backups/Keepass/keepass.kdbx -q | fzf ) ; [[ -n "$entry" ]] && nohup librewolf --new-tab $( echo -e "$password\n" | keepassxc-cli show -q -a URL dx/Backups/Keepass/keepass.kdbx "$entry" ) &> /dev/null & echo -e "$password\n" |  keepassxc-cli show dx/Backups/Keepass/keepass.kdbx "$entry" -q -a UserName | wl-copy ; watch "echo Username copied" ; echo -e "$password\n" |  keepassxc-cli show dx/Backups/Keepass/keepass.kdbx "$entry" -q -a Password | wl-copy ; watch "echo Password copied" ; echo -e "$password\n" |  keepassxc-cli show dx/Backups/Keepass/keepass.kdbx "$entry" -q -t | wl-copy ; [[ -n "$(wl-paste)" ]] && watch "echo TOTP copied" ; wl-copy -c' '';
                "mod1+Shift+h" = ''exec foot -T password sh -c 'read -s -p "Enter password: " password ; entry=$( echo -e "$password\n" |  keepassxc-cli ls dx/Backups/Keepass/keepass.kdbx -q | fzf ) ; echo -e "$password\n" |  keepassxc-cli show dx/Backups/Keepass/keepass.kdbx "$entry" -q -a UserName | wl-copy ; watch "echo Username copied" ; echo -e "$password\n" |  keepassxc-cli show dx/Backups/Keepass/keepass.kdbx "$entry" -q -a Password | wl-copy ; watch "echo Password copied" ; echo -e "$password\n" |  keepassxc-cli show dx/Backups/Keepass/keepass.kdbx "$entry" -q -t | wl-copy ; [[ -n "$(wl-paste)" ]] && watch "echo TOTP copied" ; wl-copy -c' '';
                "Print" = "exec grim -g \"$(slurp)\"";
                "mod1+f" = "fullscreen";
                "mod1+Shift+f" = "exec papersway-msg width toggle";

                #"mod1+m" = "focus left";
                #"mod1+n" = "focus down";
                #"mod1+e" = "focus up";
                #"mod1+i" = "focus right";
                "mod1+m" = "exec papersway-msg focus left";
                "mod1+n" = "focus down";
                "mod1+e" = "focus up";
                "mod1+i" = "exec papersway-msg focus right";

                #"mod1+Shift+m" = "move left";
                #"mod1+Shift+n" = "move down";
                #"mod1+Shift+e" = "move up";
                #"mod1+Shift+i" = "move right";
                "mod1+Shift+m" = "exec papersway-msg move left";
                "mod1+Shift+n" = "exec papersway-msg absorb-expel left";
                "mod1+Shift+e" = "exec papersway-msg absorb-expel right";
                "mod1+Shift+i" = "exec papersway-msg move right";

                "mod1+Ctrl+m" = "resize shrink width";
                "mod1+Ctrl+n" = "resize shrink height";
                "mod1+Ctrl+e" = "resize grow height";
                "mod1+Ctrl+i" = "resize grow width";

                "mod1+1" = "workspace number 1";
                #"mod1+2" = "workspace number 2";
                #"mod1+3" = "workspace number 3";
                #"mod1+4" = "workspace number 4";
                #"mod1+5" = "workspace number 5";
                #"mod1+6" = "workspace number 6";
                #"mod1+Left" = "workspace prev";
                #"mod1+Right" = "workspace next";
                "mod1+Tab" = "workspace back_and_forth";

                "mod1+Shift+space" = "floating toggle";
                "mod1+space" = "focus mode_toggle";

                "mod1+Shift+1" = "move container to workspace number 1";
                #"mod1+Shift+2" = "move container to workspace number 2";
                #"mod1+Shift+3" = "move container to workspace number 3";
                #"mod1+Shift+4" = "move container to workspace number 4";
                #"mod1+Shift+5" = "move container to workspace number 5";
                #"mod1+Shift+6" = "move container to workspace number 6";
                #"mod1+Shift+q" = "exit";

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
    home-manager.users.soma.services.avizo = {
        enable = true;
        settings = {
            default = {
                time = 0.5;
                image-opacity = 0.75;
                background = "rgba(160, 160, 160, 0.8)";
                border-color = "rgba(90, 90, 90, 0.8)";
                bar-fg-color = "rgba(0, 0, 0, 0.8)";
            };
        };
    };
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
