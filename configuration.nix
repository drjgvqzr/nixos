{
    config,
    pkgs,
    lib,
    ...
}: {
    imports = [
        /etc/nixos/hardware-configuration.nix
        "${
            builtins.fetchTarball {
                url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
            }
        }/nixos"
        #<nixpkgs/nixos/modules/profiles/hardened.nix>
        ./librewolf.nix
        ./zsh.nix
        ./sway.nix
        ./misc/secrets.nix
        ./misc/thunderbird.nix
        ./misc/vimium.nix
        ./misc/uBlock.nix
        ./misc/redirector.nix
    ];
    environment.systemPackages = with pkgs; [
        #Wayland
        grim
        slurp
        wf-recorder
        wlsunset
        brightnessctl
        wev
        wmenu
        wl-clipboard-rs
        hyprpicker
        autotiling-rs
        swaylock
        swayidle
        swaybg
        hunspell
        hunspellDicts.en_US-large
        hunspellDicts.hu_HU

        #CLI
        libnotify
        speedtest-go
        alsa-utils
        pulsemixer
        wget
        gh
        unrar-free
        unoconv
        jq
        ripgrep
        pandoc
        stc-cli
        woeusb
        ocrmypdf
        qrrs
        alejandra
        links2
        xdg-utils
        fzf
        unzip
        lf
        gtrash
        translate-shell
        fd
        pipe-viewer
        nix-search
        nix-search-tv
        toipe
        libqalculate
        catdocx
        ripgrep-all
        poppler_utils
        grc
        ncdu
        tree
        iftop
        openai-whisper
        speedread
        figlet
        pciutils
        fastfetch
        stress
        sunwait
        fbcat
        exfatprogs
        dash
        parted
        transmission_4

        #GUI
        obsidian
        logseq
        xfce.thunar
        tor-browser
        webcord
        mullvad-browser
        fluffychat
        bluejay
        browsh
        gfn-electron
        pavucontrol
        ungoogled-chromium
        onlyoffice-bin
        lutris
        #starsector # TEITW-HP9ON-A7HMK-WA6YA
    ];
    boot = {
        kernelParams =
            if config.networking.hostName == "Mini"
            then ["fbcon=rotate:1"]
            else [];
        initrd = {
            checkJournalingFS = true;
            luks.devices."luks".allowDiscards = true;
            systemd.enable = true;
        };
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
            timeout = 1;
        };
        supportedFilesystems = ["ntfs"];
    };
    console.useXkbConfig = true;
    environment = {
        binsh = "${pkgs.dash}/bin/dash";
        defaultPackages = [];
        pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
        shells = with pkgs; [zsh];
        sessionVariables = {
            EDITOR = "nvim";
            BROWSER = "xdg-open";
            PAGER = "nvim -R +AnsiEsc";
            GIT_PAGER = "less -R";
            MANPAGER = "nvim +Man!";
            XDG_DESKTOP_DIR = "$HOME/dn";
            XDG_DOCUMENTS_DIR = "$HOME/dx";
            XDG_DOWNLOAD_DIR = "$HOME/dn";
            XDG_MUSIC_DIR = "$HOME/dn";
            XDG_PUBLICSHARE_DIR = "$HOME/dn";
            XDG_TEMPLATES_DIR = "$HOME/dn";
            XDG_PICTURES_DIR = "$HOME/px";
            XDG_VIDEOS_DIR = "$HOME/vs";
            XDG_CONFIG_HOME = "$HOME/.config";
            XDG_CACHE_HOME = "$HOME/.cache";
            XDG_DATA_HOME = "$HOME/.local/share";
            XDG_STATE_HOME = "$HOME/.local/state";
            NIXPKGS_ALLOW_UNFREE = 1;
        };
    };
    fonts = {
        fontDir.enable = true;
        packages = with pkgs; [roboto-mono openmoji-color];
        fontconfig = {
            enable = true;
            defaultFonts = {
                monospace = ["Roboto Mono"];
                serif = ["Roboto Mono"];
                sansSerif = ["Roboto Mono"];
                emoji = ["OpenMoji Color"];
            };
        };
    };
    hardware = {
        bluetooth = {
            enable = true;
            powerOnBoot = false;
        };
        cpu.intel.updateMicrocode = true;
        graphics.enable = true;
        #sane.enable = true;
    };
    i18n.defaultLocale = "en_US.UTF-8";
    networking = {
        enableIPv6 = false;
        dhcpcd.enable = false;
        hostName =
            if builtins.pathExists /sys/kernel/btf/thinkpad_acpi
            then "W520"
            else "Mini";
        networkmanager.enable = false;
        nftables.enable = true;
        useDHCP = false;
        wg-quick.interfaces.wg0.configFile = "/home/soma/dx/nixos/misc/secrets/${config.networking.hostName}_wg.conf";
        wireless.iwd = {
            enable = true;
            settings = {
                General = {
                    EnableNetworkConfiguration = true;
                    AddressRandomization = "network";
                };
                Network = {
                    EnableIPv6 = false;
                };
            };
        };
    };
    nix = {
        gc = {
            automatic = true;
            dates = "monthly";
            options = "--delete-older-than 30d";
        };
        optimise = {
            automatic = true;
            dates = ["monthly"];
        };
    };
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
        "olm-3.2.16"
    ];
    programs = {
        adb.enable = true;
        bash.shellInit = "export HISTFILE=/tmp/bash_history";
        command-not-found.enable = true;
        dconf.enable = true;
        git = {
            enable = true;
            config = [
                {
                    user = {
                        name = "soma";
                        email = "ligma@mailbox.org";
                    };
                }
            ];
        };
        localsend.enable = true;
        nano.enable = false;
        steam = {
            enable = true;
            remotePlay.openFirewall = true;
        };
        virt-manager.enable = false;
        zsh.enable = true;
    };
    security = {
        doas = {
            enable = true;
            extraRules = [
                {
                    users = ["soma"];
                    keepEnv = true;
                    noPass = true;
                }
            ];
        };
        pam.services.swaylock = {};
        rtkit.enable = true;
        sudo.enable = false;
    };
    swapDevices = [
        {
            device = "/var/lib/swapfile";
            size = 16 * 1000;
        }
    ];
    system = {
        autoUpgrade.enable = true;
        copySystemConfiguration = true;
        stateVersion = "24.11";
    };
    systemd = {
        network = {
            enable = true;
            wait-online.enable = false;
            networks."10-lan" = {
                matchConfig.Name = "enp0s25";
                networkConfig.DHCP = "ipv4";
            };
        };
        sleep.extraConfig = "HibernateDelaySec=30m";
    };
    time.timeZone = "Europe/Budapest";
    users = {
        defaultUserShell = pkgs.zsh;
        users.soma = {
            isNormalUser = true;
            extraGroups = [
                "wheel"
                "adbusers"
            ];
        };
    };
    services = {
        auto-cpufreq = {
            enable = true;
            settings = {
                charger = {
                    governor = "powersave";
                    energy_performance_preference = "balance_performance";
                    energy_perf_bias = "balance_performance";
                };
                battery = {
                    governor = "powersave";
                    energy_performance_preference = "power";
                    energy_perf_bias = "power";
                };
            };
        };
        cron = {
            enable = true;
            systemCronJobs = [
                "*/1 * * * * soma [ $(cat /sys/class/power_supply/BAT0/capacity) -le 3 ] && [ $(cat /sys/class/power_supply/BAT0/status) = Discharging ] && systemctl hibernate"
                "* * * * 1 soma gtrash prune --size 20GB --day 90"
            ];
        };
        getty = {
            autologinUser = "soma";
            autologinOnce = true;
            extraArgs = [
                "--noissue"
                "-N"
                "--nohostname"
            ];
            greetingLine = "";
        };
        gnome.gnome-keyring.enable = true;
        logind.settings.Login = {
            HandleLidSwitch = "suspend-then-hibernate";
            HandleLidSwitchExternalPower = "suspend-then-hibernate";
            HandlePowerKey = "suspend-then-hibernate";
            HandlePowerKeyLongPress = "suspend-then-hibernate";
        };
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };
        # printing = {
        #   enable = true;
        #   drivers = [ pkgs.gutenprintBin pkgs.hplip ];
        # };
        # avahi = {
        #   enable = true;
        #   nssmdns4 = true;
        #   openFirewall = true;
        # };
        resolved = {
            enable = true;
            llmnr = "false";
            dnsovertls = "opportunistic";
            domains = ["dns.mullvad.net"];
        };
        xserver = {
            xkb.layout = "us";
            xkb.variant = "colemak_dh";
            xkb.options = "caps:backspace";
            exportConfiguration = true;
        };
    };

    home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "backup";
    };
    home-manager.users.soma = {
        programs.aichat = {
            enable = true;
            settings = {
                save = true;
                save_session = false;
                wrap = "auto";
                wrap_code = true;
                keybindings = "vi";
                rag_embedding_model = "cohere:embed-v4.0";
                rag_reranker_model = "cohere:rerank-v3.5";
                rag_chunk_size = 1000;
                rag_chunk_overlap = 50;
                document_loaders = {
                    pdf = "pdftotext $1 -";
                    epub = "pandoc --to plain $1";
                    docx = "pandoc --to plain $1";
                    odt = "pandoc --to plain $1";
                    pptx = "zsh -c \"unoconv -d presentation -f pdf --stdout $1 |pdftotext - -\"";
                };
            };
        };
        programs.kitty = {
            enable = true;
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
        programs.radio-cli = {
            enable = true;
            settings = {
                config_version = "2.3.2";
                country = "HU";
                data = [
                    {
                        station = "Barber Beats";
                        url = "https://www.youtube.com/playlist?list=PLq4DhLuDKl1ys5KHBM4PIHtvR9-tZsQHX";
                    }
                ];
                max_lines = 7;
            };
        };
        programs.mpv = {
            enable = true;
            config = {
                fullscreen = "yes";
                volume = "50";
                term-osd-bar-chars = "[/|\\]";
                gapless-audio = "yes";
                gpu-context = "wayland";
                image-display-duration = "inf";
                audio-display = "no";
                msg-level = "vo/gpu=no,vo/ffmpeg=no,ffmpeg/demuxer=no";
                term-osd-bar = "yes";
                really-quiet = "yes";
                slang = "en,de";
                #ytdl-raw-options = "sub-langs=\"en,en-orig,de,hu\"";
                sid = "no";
                volume-max = "100";
                script-opts = "sponsorblock_minimal-categories=[\"sponsor\",\"selfpromo\",\"interaction\",\"intro\",\"outro\",\"preview\",\"music_offtopic\",\"filler\"]";
                osd-font = "Roboto Mono";
                sub-font = "Roboto Mono";
            };
            scriptOpts = {
                stats = {
                    key_page_0 = "2";
                };
                webtorrent = {
                    path = "/home/soma/ar/torrents";
                    utp = "yes";
                    dht = "yes";
                };
            };
            scripts = with pkgs.mpvScripts; [
                webtorrent-mpv-hook
                sponsorblock-minimal
            ];
            bindings = {
                "a" = "add video-pan-x  +0.1";
                "s" = "add video-pan-x  -0.1";
                "w" = "add video-pan-y  +0.1";
                "r" = "add video-pan-y  -0.1";
                "t" = "add video-zoom   +0.1";
                "d" = "add video-zoom   -0.1";
                "c" = "set video-zoom 0 ; set video-pan-x 0 ; set video-pan-y 0";
                "]" = "script-binding stats/display-stats";
                "\\" = "show-progress";
                "=" = "add volume +5";
                "-" = "add volume -5";
                "0" = "cycle sub-visibility";
                "9" = "add sub-delay +0.1";
                "8" = "add sub-delay -0.1";
                "+" = "cycle video";
                "_" = "cycle audio";
                ")" = "cycle sub";
                "S" = "playlist-shuffle";
                "q" = "quit-watch-later";
                "o" = "multiply speed 1/1.1";
                "'" = "multiply speed 1.1";
                "i" = "set speed 1.0";
                "BS" = "playlist-prev";
                "ENTER" = "playlist-next";
                "ctrl+c" = "quit-watch-later";
                "[" = "ignore";
                "y" = "ignore";
                "{" = "ignore";
                "}" = "ignore";
                "p" = "ignore";
                ">" = "ignore";
                "<" = "ignore";
                "h" = "ignore";
                "1" = "ignore";
                "2" = "ignore";
                "3" = "ignore";
                "4" = "ignore";
                "5" = "ignore";
                "6" = "ignore";
                "7" = "ignore";
                "Alt+0" = "ignore";
                "Alt+1" = "ignore";
                "Alt+2" = "ignore";
                "Ctrl+s" = "ignore";
                "Alt+s" = "ignore";
                "v" = "ignore";
                "W" = "ignore";
                "j" = "ignore";
                "z" = "ignore";
                "x" = "ignore";
                "e" = "ignore";
                "b" = "ignore";
                "/" = "ignore";
                "`" = "ignore";
            };
        };
        programs.neovim = {
            enable = true;
            defaultEditor = true;
            viAlias = true;
            vimdiffAlias = true;
            #plugins = with pkgs.vimPlugins; [vim-wayland-clipboard nvimpager vim-manpager vim-plugin-AnsiEsc lightline-vim];
            plugins = with pkgs.vimPlugins; [lightline-vim vim-plugin-AnsiEsc indentLine];
            extraLuaConfig = ''vim.o.shada = ""'';
            extraConfig = ''
                set ignorecase
                set shortmess=I
                set linebreak
                set noerrorbells
                set hls is
                set wildmode=longest,list,full
                set incsearch
                set mouse=a
                set splitright
                set encoding=utf-8
                set smartcase
                set nocompatible
                set expandtab
                set tabstop=4
                set softtabstop=4
                set shiftwidth=4
                "set autoindent
                set noshowmode
                set clipboard=unnamedplus
                set nobackup
                set noswapfile
                set shm=csCFSW
                set cmdheight=0
                let g:lightline = {
                \ 'active': {
                \   'right': [ [ 'lineinfo' ],
                \              [ 'percent' ]]},}
                cabbrev wq silent wq
                cabbrev w silent w
                syntax on
                colorscheme vim
                filetype plugin on
                filetype indent on
                autocmd InsertEnter * norm zz
                autocmd BufWritePre * %s/\s\+$//e
                autocmd WinNew * wincmd L
                nnoremap S :%s///g<Left><Left><Left>
                inoremap <Esc> <Nop>
                map <F1> <Nop>
                imap <F1> <Nop>
                map <F9> :q!<CR>
                imap <F9> mn:q!<CR>
                map <F10> :q<CR>
                imap <F10> mn:q<CR>
                map <F11> :update<CR>
                imap <F11> mn:update<CR>
                map <F12> :x<CR>
                imap <F12> mn:x<CR>
                noremap m h
                noremap n j
                noremap e k
                noremap i l
                noremap N n
                noremap E N
                noremap o i
                noremap O I
                noremap ' o
                noremap " O
                inoremap ne <Esc>
                inoremap en <Esc>
                nmap <A-F1> <Nop>
                let g:netrw_dirhistmax = 0
                autocmd VimEnter * :MatchDisable
                noremap <Up> <Nop>
                noremap <Down> <Nop>
                noremap <Left> <Nop>
                noremap <Right> <Nop>
                inoremap <Up> <Nop>
                inoremap <Down> <Nop>
                inoremap <Left> <Nop>
                inoremap <Right> <Nop>
                noremap <PageDown> <Nop>
                noremap <PageUp> <Nop>
                noremap <Home> <Nop>
                noremap <End> <Nop>'';
        };
        programs.keepassxc = {
            enable = true;
            settings = {
                GUI = {
                    ApplicationTheme = "dark";
                    HideGroupPanel = true;
                };
                Security = {
                    ClearClipboardTimeout = 15;
                    IconDownloadFallback = true;
                    LockDatabaseIdle = true;
                    LockDatabaseIdleSeconds = 600;
                    PasswordsHidden = false;
                    HidePasswordPreviewPanel = false;
                };
            };
        };
        services.mako = {
            enable = true;
            settings = {
                default-timeout = 5000;
                #on-notify = "exec mpv /usr/share/sounds/freedesktop/stereo/message.oga";
            };
        };
        xdg = {
            enable = true;
            desktopEntries = {
                librewolf = {
                    name = "LibreWolf";
                    exec = "${pkgs.librewolf}/bin/librewolf";
                };
                zathura = {
                    name = "Zathura";
                    exec = "${pkgs.zathura}/bin/zathura";
                };
                transmission = {
                    name = "Transmission";
                    exec = "transmission-cli -er -w /home/soma/ar/torrents \\$f";
                };
            };
            mimeApps = {
                enable = true;
                defaultApplications = {
                    "text/html" = "librewolf.desktop";
                    "x-scheme-handler/http" = "librewolf.desktop";
                    "x-scheme-handler/https" = "librewolf.desktop";
                    "x-scheme-handler/about" = "librewolf.desktop";
                    "x-scheme-handler/unknown" = "librewolf.desktop";
                    "x-scheme-handler/mailto" = "thunderbird.desktop";
                    "application/pdf" = "zathura.desktop";
                    "video/mp4" = "mpv.desktop";
                    "video/webm" = "mpv.desktop";
                    "video/quicktime" = "mpv.desktop";
                    "video/mpeg" = "mpv.desktop";
                    "video/x-matroska" = "mpv.desktop";
                    "audio/mpeg" = "mpv.desktop";
                    "audio/wav" = "mpv.desktop";
                    "audio/ogg" = "mpv.desktop";
                    "audio/aac" = "mpv.desktop";
                    "audio/flac" = "mpv.desktop";
                    "image/png" = "mpv.desktop";
                    "image/jpeg" = "mpv.desktop";
                    "image/webp" = "mpv.desktop";
                    "text/plain" = "nvim.desktop";
                    "application/json" = "nvim.desktop";
                    "application/xml" = "nvim.desktop";
                    "text/css" = "nvim.desktop";
                    "text/javascript" = "nvim.desktop";
                    "application/javascript" = "nvim.desktop";
                    "text/markdown" = "nvim.desktop";
                    "application/yaml" = "nvim.desktop";
                    "text/x-python" = "nvim.desktop";
                    "text/x-sh" = "nvim.desktop";
                    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "onlyoffice-desktopeditors.desktop";
                    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "onlyoffice-desktopeditors.desktop";
                    "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "onlyoffice-desktopeditors.desktop";
                    "application/x-bittorrent" = "transmission.desktop";
                };
            };
            portal = {
                enable = true;
                extraPortals = [pkgs.xdg-desktop-portal-gtk];
                config.common.default = ["gtk"];
                xdgOpenUsePortal = false;
            };
            userDirs = {
                enable = true;
                desktop = "/home/soma/ar";
                documents = "/home/soma/dx";
                download = "/home/soma/dn";
                pictures = "/home/soma/px";
                videos = "/home/soma/vs";
            };
        };
        gtk = {
            enable = true;
            theme.name = "Adwaita-dark";
            theme.package = pkgs.gnome-themes-extra;
        };
        qt = {
            enable = true;
            platformTheme.name = "adwaita";
            style.name = "adwaita-dark";
            style.package = pkgs.adwaita-qt;
        };
        dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
        programs.zathura = {
            enable = true;
            mappings = {
                "w" = "scroll up";
                "a" = "scroll left";
                "r" = "scroll down";
                "s" = "scroll right";
                "m" = "scroll left";
                "n" = "scroll down";
                "e" = "scroll up";
                "i" = "scroll right";
                "t" = "zoom in";
                "d" = "zoom out";
                "p" = "snap_to_page";
                "x" = "adjust_window best-fit";
                "c" = "adjust_window width";
                "N" = "search backward";
                "M" = "search forward";
                "D" = "toggle_page_mode";
                "u" = "navigate previous";
                "l" = "navigate next";
                "R" = "rotate";
            };
            options = {
                guioptions = "vh";
                adjust-open = "best-fit";
                inputbar-bg = "#000000";
                inputbar-fg = "#FFFFFF";
                recolor = "true";
                selection-clipboard = "clipboard";
            };
        };
        programs.freetube = {
            enable = true;
            settings = {
                autoplayVideos = true;
                baseTheme = "black";
                checkForBlogPosts = false;
                checkForUpdates = false;
                downloadAskPath = false;
                downloadBehavior = "download";
                downloadFolderPath = "/home/soma/vs";
                externalPlayerCustomArgs = "[\"--force-window=immediate\"]";
                externalPlayer = "mpv";
                generalAutoLoadMorePaginatedItemsEnabled = true;
                hideActiveSubscriptions = true;
                hideChannelCommunity = true;
                hideChannelPodcasts = true;
                hideChannelReleases = true;
                hideChannelShorts = true;
                hideFeaturedChannels = true;
                hideHeaderLogo = true;
                hideLabelsSideBar = true;
                hideLiveChat = true;
                hideLiveStreams = true;
                hidePlaylists = true;
                hidePopularVideos = true;
                hideSharingActions = true;
                hideTrendingVideos = true;
                hideUpcomingPremieres = true;
                landingPage = "subscribedchannels";
                maxVideoPlaybackRate = 2;
                showDistractionFreeTitles = true;
                sponsorBlockFiller = "{\"color\":\"Purple\",\"skip\":\"autoSkip\"}";
                sponsorBlockInteraction = "{\"color\":\"Pink\",\"skip\":\"autoSkip\"}";
                sponsorBlockIntro = "{\"color\":\"Cyan\",\"skip\":\"autoSkip\"}";
                sponsorBlockMusicOffTopic = "{\"color\":\"Orange\",\"skip\":\"autoSkip\"}";
                sponsorBlockOutro = "{\"color\":\"Blue\",\"skip\":\"autoSkip\"}";
                sponsorBlockRecap = "{\"color\":\"Indigo\",\"skip\":\"autoSkip\"}";
                sponsorBlockSelfPromo = "{\"color\":\"Yellow\",\"skip\":\"autoSkip\"}";
                useDeArrowTitles = true;
                useSponsorBlock = true;
                videoPlaybackRateMouseScroll = true;
                videoVolumeMouseScroll = true;
            };
        };
        programs.newsboat = {
            enable = true;
            browser = "/etc/profiles/per-user/soma/bin/mpv";
            extraConfig = ''                color listfocus black white
                color listfocus_unread black white bold
                color title black black
                color info black black
                macro , open-in-browser
                ignore-mode "display"
                ignore-article "*" "title # \"#shorts\" or description # \"#shorts\" or content # \"#shorts\" or link # \"shorts\""
                cleanup-on-quit yes
                macro a set browser "yt-dlp --write-auto-sub -q --no-warnings --skip-download -o /tmp/sub %u ; cat /tmp/sub.en.vtt| sed -e '/^[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}\.[0-9]\{3\} -->/d' -e '/^[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}\.[0-9]\{3\}/d' -e 's/<[^>]*>/g'| awk 'NF'| sed 's/$/ /'| tr -d '\n'| aichat 'give a detailed summary of the previous text with the main points. Do not mention any promotions or sponsors.'|less";open-in-browser;set browser mpv'';
        };
        programs.btop = {
            enable = true;
            settings = {
                update_ms = 100;
                proc_sorting = "cpu direct";
                proc_per_core = true;
                proc_left = true;
                proc_filter_kernel = true;
                cpu_single_graph = true;
                show_coretemp = false;
                base_10_sizes = true;
                mem_graphs = false;
                show_swap = true;
                swap_disk = false;
                net_sync = false;
            };
        };
        programs.yt-dlp = {
            enable = true;
            settings = {
                format-sort = "res:1080";
                retries = "infinite";
                file-access-retries = "infinite";
                fragment-retries = "infinite";
                extractor-retries = "infinite";
                #extractor-args = "youtube:player_skip=configs,js;player_client=ios";
                #embed-subs = true;
                #write-subs = true;
                #write-auto-subs = true;
                #sub-langs = "en,en-orig,de";
                embed-chapters = true;
                #embed-metadata = true;
                sponsorblock-remove = "all";
            };
        };
        home = {
            pointerCursor = {
                enable = true;
                package = pkgs.vanilla-dmz;
                name = "Vanilla-DMZ-AA";
                size = 24;
                sway.enable = true;
            };
            stateVersion = "24.11";
            preferXdgDirectories = true;
            file = {
                mime_handlers = {
                    enable = true;
                    force = true;
                    target = ".librewolf/default/handlers.json";
                    text = ''                        {
                        "defaultHandlersVersion": {},
                            "mimeTypes": {
                                "application/pdf": {
                                    "action": 4,
                                    "extensions": [
                                        "pdf"
                                    ]
                                },
                                "application/vnd.openxmlformats-officedocument.wordprocessingml.document": {
                                    "action": 4,
                                    "extensions": [
                                        "docx"
                                    ]
                                },
                                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet": {
                                    "action": 4,
                                    "extensions": [
                                        "xlsx"
                                    ]
                                },
                                "application/vnd.openxmlformats-officedocument.presentationml.presentation": {
                                    "action": 4,
                                    "extensions": [
                                        "pptx"
                                    ]
                                },
                                "image/webp": {
                                    "action": 3,
                                    "extensions": [
                                        "webp"
                                    ]
                                },
                                "image/avif": {
                                    "action": 3,
                                    "extensions": [
                                        "avif"
                                    ]
                                }
                            },
                            "schemes": {
                                "mailto": {
                                    "handlers": [
                                        {
                                            "name": "Thunderbird",
                                            "command": "thunderbird --name thunderbird %U"
                                        }
                                    ],
                                    "action": 2
                                },
                                "magnet": {
                                    "action": 2,
                                    "handlers": [
                                        {
                                            "name": "mpv",
                                            "path": "/etc/profiles/per-user/soma/bin/mpv"
                                        }
                                    ],
                                    "ask": false
                                }
                            },
                            "isDownloadsImprovementsAlreadyMigrated": false
                        }
                    '';
                };
                dotpulse-cookie = {
                    enable = true;
                    force = true;
                    target = ".config/pulse/client.conf";
                    text = "cookie-file = ~/.config/pulse/cookie";
                };
                violentmonkey = {
                    enable = true;
                    force = true;
                    target = ".librewolf/default/browser-extension-data/{aecec67f-0d10-4fa7-b7c7-609a2db280cf}/storage.js";
                    source = "/home/soma/dx/nixos/misc/violentmonkey";
                };
                links = {
                    enable = true;
                    force = true;
                    target = ".links";
                    source = "/home/soma/dx/nixos/misc/.links";
                };
                kitty_open = {
                    enable = false;
                    force = true;
                    target = ".config/kitty/open-actions.conf";
                    text = ''
                        # Change directory in shell
                        protocol file
                        mime inode/directory
                        action launch --cwd=$FILE_PATH --type=overlay

                        #xdg-open
                        protocol file
                        *
                        action launch --type=overlay xdg-open $\{FILE_PATH}
                    '';
                };
            };
        };
    };
}
