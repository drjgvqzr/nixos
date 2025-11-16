{
    config,
    pkgs,
    lib,
    ...
}: {
    programs.alacritty = {
        enable = false;
        settings = {
            font.size = 14;
            window = {
                padding = {
                    x = 5;
                    y = 0;
                };
                dynamic_padding = true;
            };
            selection.save_to_clipboard = true;
            cursor = {
                style = {
                    shape = "Underline";
                    blinking = "On";
                };
                blink_interval = 500;
                blink_timeout = 0;
            };
            mouse.hide_when_typing = true;
            colors = {
                primary.background = "#000000";
                normal = {
                    black = "#000000";
                    red = "#aa0000";
                    green = "#00aa00";
                    yellow = "#aa5500";
                    blue = "#0000ff";
                    magenta = "#aa00aa";
                    cyan = "#00aaaa";
                    white = "#aaaaaa";
                };
                bright = {
                    black = "#555555";
                    red = "#ff5555";
                    green = "#55ff55";
                    yellow = "#ffff55";
                    blue = "#5555ff";
                    magenta = "#ff55ff";
                    cyan = "#55ffff";
                    white = "#ffffff";
                };
            };
            keyboard.bindings = [
                {
                    key = "V";
                    mods = "Control";
                    action = "Paste";
                }
                {
                    key = "PageUp";
                    mods = "Control";
                    action = "ScrollPageUp";
                }
                {
                    key = "PageDown";
                    mods = "Control";
                    action = "ScrollPageDown";
                }
                {
                    key = "Home";
                    mods = "Control";
                    action = "ScrollToTop";
                }
                {
                    key = "End";
                    mods = "Control";
                    action = "ScrollToBottom";
                }
            ];
        };
    };
    programs.kitty = {
        enable = false;
        extraConfig = ''
            mouse_map ctrl+right press ungrabbed mouse_show_command_output
        '';
        keybindings = {
            "ctrl+c" = "copy_or_interrupt";
            "ctrl+v" = "paste_from_clipboard";
            "ctrl+page_down" = "scroll_page_down";
            "ctrl+page_up" = "scroll_page_up";
            "ctrl+home" = "scroll_home";
            "ctrl+end" = "scroll_end";
            "ctrl+e" = "kitten hints --hints-offset=0 --alphabet=farst --program default";
            "ctrl+y" = "kitten hints --hints-offset=0 --alphabet=farst --program @";
            "ctrl+o" = "kitten hints --hints-offset=0 --alphabet=farst --type hyperlink --program default";
            "ctrl+g" = "show_last_command_output";
        };
        font = {
            name = "Roboto Mono";
            package = pkgs.roboto-mono;
            size = 14;
        };
        settings = {
            cursor_shape = "underline";
            enable_audio_bell = false;
            confirm_os_window_close = 0;
            mouse_hide_wait = -1;
            clear_selection_on_clipboard_loss = "yes";
            strip_trailing_spaces = "smart";
            scrollback_pager = "nvim -R +AnsiEsc +INPUT_LINE_NUMBER";
            color0 = "#000000";
            color1 = "#aa0000";
            color2 = "#00aa00";
            color3 = "#aa5500";
            color4 = "#0000ff";
            color5 = "#aa00aa";
            color6 = "#00aaaa";
            color7 = "#aaaaaa";
            color8 = "#555555";
            color9 = "#ff5555";
            color10 = "#55ff55";
            color11 = "#ffff55";
            color12 = "#5555ff";
            color13 = "#ff55ff";
            color14 = "#55ffff";
            color15 = "#ffffff";
        };
        shellIntegration.mode = "no-cursor";
    };
}
