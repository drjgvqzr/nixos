{
    lib,
    pkgs,
    ...
}: let
    nixos = "/home/soma/dx/nixos";
    secret = name: lib.strings.trim (builtins.readFile "${nixos}/misc/secrets/${name}");
in {
    boot = {
        initrd.luks.devices."luks".allowDiscards = true;
        kernelPackages = pkgs.linuxPackages_latest;
        kernelParams = ["fbcon=rotate:1" "video=DSI-1:panel_orientation=right_side_up"];
        loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
            timeout = 0;
        };
    };
    console.useXkbConfig = true;
    environment = {
        binsh = "${pkgs.dash}/bin/dash";
        pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
        sessionVariables = {
            BROWSER = "handlr open";
            DOTREMINDERS = "$HOME/dx/Backups/remind/remind.rem";
            GIT_PAGER = "less -R";
            GTK_CSD = "0";
            MANPAGER = "nvim +Man!";
            PAGER = "nvim -R +AnsiEsc";
        };
        shells = [pkgs.fish];
        systemPackages = with pkgs; [
            #CLI
            alejandra
            android-tools
            any-nix-shell
            astroterm
            autotiling-rs
            backgroundremover
            bat
            bc
            catdocx
            cointop
            cook-cli
            dash
            dejsonlz4
            doxx
            dust
            exfatprogs
            exiftool
            eza
            f3
            fastfetch
            fbcat
            fd
            fdupes
            ffmpeg
            figlet
            fishPlugins.autopair
            fishPlugins.grc
            fishPlugins.puffer
            fzf
            fzf-preview
            gallery-dl
            gcc
            gdu
            gh
            ghc
            gnumake
            gomuks
            grc
            groff
            gtrash
            handlr-regex
            heimdall
            html2text
            hyperfine
            iftop
            imagemagick
            invoice
            inxi
            iwqr
            jaq
            keepass-diff
            libnotify
            libqalculate
            libreoffice
            links2
            lm_sensors
            lolcat
            mailsy
            mapscii
            mdcat
            nautilus
            nixos-anywhere
            nix-search-tv
            nushell
            ocrmypdf
            openai-whisper
            opencode
            oterm
            ouch-rar
            pandoc
            parted
            pastel
            pciutils
            pdftk
            pipe-rename
            piper-tts
            pipe-viewer
            poppler-utils
            presenterm
            prismlauncher
            procs
            pulsemixer
            python315
            qrrs
            rclone
            remind
            ripgrep
            ripgrep-all
            sd
            smartmontools
            solitaire-tui
            sox
            speedread
            speedtest-go
            stc-cli
            steamguard-cli
            stress
            sunwait
            ticker
            tickrs
            timer
            tlrc
            toipe
            translate-shell
            transmission_4-gtk
            ttdl
            unoconv
            uutils-coreutils-noprefix
            uutils-diffutils
            uutils-findutils
            uutils-login
            uutils-sed
            uutils-tar
            vulkan-tools
            wget2
            wikit
            wiki-tui
            woeusb
            xdg-utils
            zbar
            zoxide

            #Wayland
            brightnessctl
            grim
            hunspell
            hunspellDicts.en_US-large
            hunspellDicts.hu_HU
            hyprpicker
            slurp
            swaylock
            tesseract
            wev
            wl-screenrec
            wl-clipboard-rs
            wmenu

            #GUI
            audacity
            bluejay
            brave
            electron-mail
            firefox
            fluffychat
            gamescope #gamemoderun %command%
            gimp
            googleearth-pro
            iwgtk
            kdePackages.kdenlive
            kdePackages.kolourpaint
            kdiskmark
            logseq
            lutris
            mullvad-browser
            onlyoffice-desktopeditors
            pavucontrol
            qdirstat
            rustdesk-flutter
            #starsector # TEITW-HP9ON-A7HMK-WA6YA
            tor-browser
            ungoogled-chromium
            vesktop
            zotero
        ];
    };
    fonts = {
        fontconfig.defaultFonts = {
            emoji = ["Noto Color Emoji"];
            monospace = ["Roboto Mono"];
            sansSerif = ["Roboto Mono"];
            serif = ["Roboto Mono"];
        };
        packages = with pkgs; [noto-fonts-color-emoji roboto-mono unifont];
    };
    hardware = {
        bluetooth.enable = true;
        cpu.intel.updateMicrocode = true;
        graphics.enable = true;
        sane.enable = true;
    };
    imports = [
        "${
            builtins.fetchTarball {
                url = "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
                sha256 = "1qsx6l8z2v2rzr47chfqvmr9585lcrb2wihixbklmz63nhsba6sb";
            }
        }/nixos"
        #./fish.nix
        ./librewolf.nix
        ./sway.nix
        /etc/nixos/hardware-configuration.nix
    ];
    networking = {
        enableIPv6 = false;
        dhcpcd.enable = false;
        nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
        wg-quick.interfaces.wg0.configFile = "${nixos}/misc/secrets/wg.conf";
        wireless.iwd = {
            enable = true;
            settings.General = {
                AddressRandomization = "network";
                EnableNetworkConfiguration = true;
            };
        };
    };
    nixpkgs.config = {
        allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["googleearth-pro" "steam" "steam-unwrapped" "starsector" "ouch"];
        permittedInsecurePackages = ["olm-3.2.16" "googleearth-pro-7.3.7.1155" "electron-39.8.10"];
    };
    programs = {
        bash.shellInit = "export HISTFILE=/tmp/bash_history";
        command-not-found.enable = true;
        dconf.enable = true;
        fish.enable = true;
        gamemode.enable = true;
        git.enable = true;
        gnupg.agent.enable = true;
        steam.enable = true;
    };
    security = {
        doas = {
            enable = true;
            extraRules = [
                {
                    keepEnv = true;
                    noPass = true;
                    users = ["soma"];
                }
            ];
        };
        pam.services.swaylock = {};
        rtkit.enable = true;
        sudo.enable = false;
    };
    services = {
        auto-cpufreq = {
            enable = true;
            settings = {
                battery = {
                    energy_perf_bias = "power";
                    energy_performance_preference = "power";
                    governor = "powersave";
                    turbo = "never";
                };
                charger = {
                    energy_perf_bias = "balance_performance";
                    energy_performance_preference = "balance_performance";
                    governor = "powersave";
                    turbo = "auto";
                };
            };
        };
        avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
        };
        borgmatic = {
            enable = true;
            configurations.local = {
                repositories = [
                    {
                        label = "local";
                        path = "~/ar/borg";
                    }
                ];
                source_directories = [
                    "~/dx"
                    "~/px"
                    "~/ph"
                    "~/dn"
                    "~/.ssh"
                    "~/.gnupg"
                    "~/.config"
                    "~/.librewolf"
                    "~/.local"
                ];
                exclude_patterns = [
                    "~/.local/share/Trash"
                    "~/.local/share/Steam"
                    "~/.local/share/lutris"
                ];
                compression = "zstd";
                keep_daily = 7;
                keep_weekly = 4;
                keep_monthly = 6;
                keep_yearly = 10;
                encryption_passcommand = "cat ${nixos}/misc/secrets/borgmatic";
            };
        };
        fcron = {
            enable = true;
            systab = ''
                %hourly * curl -s "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=WEBN.DEX&apikey=7MDJ3EFDVAYP245U" | jaq -r '."Global Quote"."05. price"' | sed 's/\(.*\...\).*/\1€/' > /tmp/webn
            '';
        };
        getty = {
            autologinOnce = true;
            autologinUser = "soma";
            extraArgs = ["--nohostname" "--noissue" "-N"];
            greetingLine = "";
        };
        gnome.gnome-keyring.enable = true;
        logind.settings.Login = {
            HandleLidSwitch = "suspend-then-hibernate";
            HandleLidSwitchExternalPower = "suspend-then-hibernate";
            HandlePowerKey = "suspend-then-hibernate";
            HandlePowerKeyLongPress = "suspend-then-hibernate";
        };
        ollama = {
            enable = true;
            loadModels = ["gemma4:e2b"];
        };
        pipewire = {
            enable = true;
            alsa.enable = true;
            pulse.enable = true;
        };
        playerctld.enable = true;
        printing = {
            enable = true;
            drivers = [
                pkgs.gutenprintBin
                pkgs.hplip
                pkgs.epson-escpr
                pkgs.epson-escpr2
                pkgs.brlaser
                pkgs.splix
                pkgs.postscript-lexmark
            ];
        };
        resolved = {
            enable = true;
            settings.Resolve = {
                DNSSEC = "true";
                DNSOverTLS = "true";
                Domains = ["~."];
            };
        };
        syncthing = {
            enable = true;
            cert = "${nixos}/misc/secrets/cert.pem";
            dataDir = "/home/soma";
            group = "users";
            key = "${nixos}/misc/secrets/key.pem";
            openDefaultPorts = true;
            settings = {
                devices = {
                    "Backup".id = secret "Backup_st-id";
                    "Laptop".id = secret "Laptop_st-id";
                    "Phone".id = secret "Phone_st-id";
                };
                folders = {
                    "ar" = {
                        devices = ["Laptop" "Backup"];
                        id = "ciwug-fwawa";
                        path = "~/ar";
                    };
                    "dn" = {
                        devices = ["Laptop" "Backup" "Phone"];
                        id = "eztfs-xg2pf";
                        path = "~/dn";
                    };
                    "dx" = {
                        devices = ["Laptop" "Backup" "Phone"];
                        id = "oh2oz-9t565";
                        path = "~/dx";
                    };
                    "ph" = {
                        devices = ["Laptop" "Backup" "Phone"];
                        id = "domno-sd3ps";
                        path = "~/ph";
                    };
                    "px" = {
                        devices = ["Laptop" "Backup" "Phone"];
                        id = "d0ind-uzt2e";
                        path = "~/px";
                    };
                    "vs" = {
                        devices = ["Laptop" "Backup"];
                        id = "7sr22-b5ui1";
                        path = "~/vs";
                    };
                };
            };
            user = "soma";
        };
        thermald.enable = true;
        xserver.xkb = {
            layout = "us";
            options = "caps:backspace";
            variant = "colemak_dh";
        };
    };
    swapDevices = [
        {
            device = "/var/lib/swapfile";
            size = 16000;
        }
    ];
    system = {
        autoUpgrade = {
            enable = true;
            dates = "Saturday";
            runGarbageCollection = true;
        };
        stateVersion = "26.05";
    };
    systemd.sleep.settings.Sleep.HibernateDelaySec = "3h";
    time.timeZone = "Europe/Budapest";
    users.users.soma = {
        shell = pkgs.fish;
        isNormalUser = true;
    };
    home-manager = {
        backupFileExtension = "backup";
        useGlobalPkgs = true;
        useUserPackages = true;
        users.soma = {
            programs = {
                aichat = {
                    enable = true;
                    settings = {
                        clients = [
                            {
                                type = "openai-compatible";
                                name = "openrouter";
                                api_base = "https://openrouter.ai/api/v1";
                                api_key = secret "openrouter";
                                patch.chat_completions.".*".body = {
                                    provider = {
                                        preferred_max_latency = 1.2;
                                        preferred_min_throughput = 35;
                                        quantizations = ["fp8"];
                                        sort = "price";
                                        zdr = true; #https://openrouter.ai/docs/api/api-reference/chat/
                                    };
                                    reasoning.effort = "none"; #"xhigh", "high", "medium", "low", "minimal" or "none"
                                };
                                models = [
                                    {
                                        name = "deepseek-v4-flash-0731";
                                        system_prompt_prefix = secret "ai_sysprompt";
                                    }
                                    {
                                        name = "qwen/qwen3-embedding-8b";
                                        type = "embedding";
                                    }
                                    {
                                        name = "cohere/rerank-4-pro";
                                        type = "reranker";
                                    }
                                ];
                            }
                            {
                                type = "openai-compatible";
                                name = "thinking";
                                api_base = "https://openrouter.ai/api/v1";
                                api_key = secret "openrouter";
                                patch.chat_completions.".*".body = {
                                    provider = {
                                        preferred_max_latency = 1.2;
                                        preferred_min_throughput = 35;
                                        quantizations = ["fp8"];
                                        sort = "price";
                                        zdr = true; #https://openrouter.ai/docs/api/api-reference/chat/
                                    };
                                    reasoning.effort = "xhigh"; #"xhigh", "high", "medium", "low", "minimal" or "none"
                                    reasoning.exclude = true;
                                };
                                models = [
                                    {
                                        name = "deepseek-v4-flash-0731";
                                        system_prompt_prefix = secret "ai_sysprompt";
                                    }
                                    {
                                        name = "qwen/qwen3-embedding-8b";
                                        type = "embedding";
                                    }
                                    {
                                        name = "cohere/rerank-4-pro";
                                        type = "reranker";
                                    }
                                ];
                            }
                            {
                                type = "openai-compatible";
                                name = "internet";
                                api_base = "https://openrouter.ai/api/v1";
                                api_key = secret "openrouter";
                                patch.chat_completions.".*".body = {
                                    provider = {
                                        preferred_max_latency = 1.2;
                                        preferred_min_throughput = 35;
                                        quantizations = ["fp8"];
                                        sort = "price";
                                        zdr = true; #https://openrouter.ai/docs/api/api-reference/chat/
                                    };
                                    #reasoning.effort = "none"; #"xhigh", "high", "medium", "low", "minimal" or "none"
                                    reasoning.exclude = true;
                                    tools = [
                                        {
                                            type = "openrouter:web_search";
                                            parameters.engine = "native";
                                        }
                                        {
                                            type = "openrouter:datetime";
                                        }
                                        {
                                            type = "openrouter:web_fetch";
                                            parameters.engine = "native";
                                        }
                                    ];
                                };
                                models = [
                                    {
                                        name = "deepseek-v4-flash-0731";
                                        system_prompt_prefix = secret "ai_sysprompt";
                                    }
                                ];
                            }
                            {
                                type = "openai-compatible";
                                name = "ollama";
                                api_base = "http://localhost:11434/v1";
                                models = [
                                    {
                                        name = "gemma4:e2b";
                                        temperature = 1.0;
                                        top_p = 0.95;
                                        top_k = 64;
                                    }
                                ];
                            }
                        ];
                        document_loaders = {
                            docx = "pandoc --to plain $1";
                            epub = "pandoc --to plain $1";
                            odt = "pandoc --to plain $1";
                            pdf = "pdftotext $1 -";
                            pptx = "sh -c \"unoconv -d presentation -f pdf --stdout $1 |pdftotext - -\"";
                        };
                        keybindings = "vi";
                        rag_chunk_overlap = 50;
                        rag_chunk_size = 1000;
                        rag_embedding_model = "openrouter:qwen/qwen3-embedding-8b";
                        rag_reranking_model = "openrouter:cohere/rerank-v4-pro";
                        save = true;
                        save_session = false;
                        wrap = "auto";
                        wrap_code = true;
                    };
                };
                broot.enable = true;
                btop = {
                    enable = true;
                    settings = {
                        base_10_sizes = true;
                        check_temp = false;
                        cpu_single_graph = true;
                        mem_graphs = false;
                        net_iface = "wlan0";
                        net_sync = false;
                        proc_cpu_graphs = false;
                        proc_filter_kernel = true;
                        proc_left = true;
                        proc_per_core = true;
                        proc_sorting = "cpu direct";
                        show_coretemp = false;
                        show_swap = true;
                        swap_disk = true;
                        update_ms = 100;
                    };
                };
                dircolors = {
                    enable = true;
                    settings = {
                        ".docx" = "01;33";
                        ".epub" = "01;93";
                        ".odt" = "01;33";
                        ".pdf" = "01;93";
                        ".pptx" = "01;33";
                        ".rtf" = "01;33";
                        ".xlsx" = "01;33";
                    };
                };
                foot = {
                    enable = true;
                    settings = {
                        colors-dark = {
                            background = "000000";
                            bright0 = "555555";
                            bright1 = "ff5555";
                            bright2 = "55ff55";
                            bright3 = "ffff55";
                            bright4 = "5555ff";
                            bright5 = "ff55ff";
                            bright6 = "55ffff";
                            bright7 = "ffffff";
                            foreground = "ffffff";
                            regular0 = "000000";
                            regular1 = "aa0000";
                            regular2 = "00aa00";
                            regular3 = "aa5500";
                            regular4 = "3333ff";
                            regular5 = "aa00aa";
                            regular6 = "00aaaa";
                            regular7 = "aaaaaa";
                        };
                        cursor.underline-thickness = "2px";
                        key-bindings = {
                            clipboard-paste = "Control+v";
                            scrollback-up-page = "Control+Page_Up";
                            scrollback-down-page = "Control+Page_Down";
                            scrollback-home = "Control+Home";
                            scrollback-end = "Control+End";
                            show-urls-copy = "Control+y";
                            search-start = "Control+slash";
                        };
                        main = {
                            font = "Roboto Mono:size=14";
                            pad = "5x0";
                            selection-target = "clipboard";
                        };
                        scrollback.lines = 100000;
                        search-bindings = {
                            find-prev = "Shift+e";
                            find-next = "Shift+n";
                        };
                    };
                };
                keepassxc = {
                    enable = true;
                    settings = {
                        GUI.HideGroupPanel = true;
                        Security = {
                            ClearClipboardTimeout = 15;
                            HidePasswordPreviewPanel = false;
                            IconDownloadFallback = true;
                            LockDatabaseIdle = true;
                            LockDatabaseIdleSeconds = 600;
                            PasswordsHidden = false;
                        };
                    };
                };
                mpv = {
                    enable = true;
                    bindings = {
                        # === Playlist & Quit ===
                        "DEL" = "run gtrash put \${path} ; playlist-next";
                        BS = "playlist-prev";
                        ENTER = "playlist-next";
                        S = "playlist-shuffle";
                        q = "quit-watch-later";
                        "ctrl+c" = "quit-watch-later";

                        # === Seek ===
                        RIGHT = "seek 5";
                        LEFT = "seek -5";
                        UP = "seek 60";
                        DOWN = "seek -60";
                        HOME = "seek 0 absolute";
                        PGUP = "add chapter 1";
                        PGDWN = "add chapter -1";
                        "." = "frame-step";
                        "," = "frame-back-step";

                        # === Playback Speed ===
                        o = "multiply speed 1/1.1";
                        "'" = "multiply speed 1.1";
                        i = "set speed 1.0";

                        # === Pause & Fullscreen ===
                        SPACE = "cycle pause";
                        MBTN_LEFT_DBL = "cycle fullscreen";
                        f = "cycle fullscreen";

                        # === Pan & Zoom & Rotate ===
                        a = "add video-pan-x  +0.1";
                        s = "add video-pan-x  -0.1";
                        w = "add video-pan-y  +0.1";
                        r = "add video-pan-y  -0.1";
                        t = "add video-zoom   +0.1";
                        d = "add video-zoom   -0.1";
                        c = "set video-zoom 0 ; set video-pan-x 0 ; set video-pan-y 0";
                        R = "cycle_values video-rotate 90 180 270 0";

                        # === Audio & Video Tracks ===
                        m = "cycle mute";
                        "+" = "cycle video";
                        _ = "cycle audio";
                        ")" = "cycle sub";

                        # === Subtitles ===
                        "0" = "cycle sub-visibility";
                        "9" = "add sub-delay +0.1";
                        "8" = "add sub-delay -0.1";

                        # === Loop ===
                        l = "ab-loop";
                        L = "cycle-values loop-file \"inf\" \"no\"";

                        # === OSD & Scripts ===
                        "]" = "script-binding stats/display-stats";
                        "\\" = "show-progress";
                        b = "script-binding sponsorblock_minimal/sponsorblock";
                        g = "script-message playlist-view-toggle";
                        p = "script-binding webtorrent/toggle-info";
                    };
                    config = {
                        fullscreen = true;
                        image-display-duration = "inf";
                        input-default-bindings = false;
                        msg-level = "vo/gpu=no,vo/ffmpeg=no,ffmpeg/demuxer=no,ffmpeg=no,input=no";
                        osc = false;
                        osd-font = "Roboto Mono";
                        sub-font = "Roboto Mono";
                        term-osd-bar = true;
                        term-osd-bar-chars = "[/|\\]";
                        volume-max = "100";
                        ytdl-format = "bestvideo[height<=720]+bestaudio/best[height<=720]";
                    };
                    scriptOpts = {
                        sponsorblock_minimal.categories = "sponsor;selfpromo;interaction;intro;outro;preview;hook;music_offtopic;filler";
                        thumbfast.network = "yes";
                        webtorrent.path = "~/tr/";
                    };
                    scripts = with pkgs.mpvScripts; [
                        mpris
                        mpv-gallery-view
                        sponsorblock-minimal
                        thumbfast
                        uosc
                        webtorrent-mpv-hook
                    ];
                };
                neovim = {
                    enable = true;
                    defaultEditor = true;
                    viAlias = true;
                    plugins = with pkgs.vimPlugins; [indentLine lightline-vim nvim-highlight-colors todo-txt-vim Improved-AnsiEsc];
                    initLua = ''
                        vim.o.shada = ""
                        require('nvim-highlight-colors').setup({})'';
                    extraConfig = ''
                        " === General Settings ===
                        set nobackup
                        set noswapfile
                        set undofile
                        set undodir=~/.config/nvim/undo//
                        set clipboard=unnamedplus
                        set cmdheight=0

                        " === Search ===
                        set smartcase
                        set ignorecase

                        " === Display ===
                        set linebreak
                        colorscheme vim

                        " === Indentation ===
                        set expandtab
                        set tabstop=4
                        set shiftwidth=4

                        " === Filetype ===
                        "filetype plugin on
                        "filetype indent on

                        " === Lightline ===
                        let g:lightline = {
                        \ 'active': {
                        \   'right': [ [ 'lineinfo' ],
                        \              [ 'percent' ]]},
                        \}

                        " === Command Abbreviations ===
                        cabbrev wq silent wq
                        cabbrev w silent w

                        " === Remap Navigation Keys ===
                        noremap m h
                        noremap n j
                        noremap e k
                        noremap i l
                        noremap l e
                        noremap N n
                        noremap E N
                        noremap o i
                        noremap O I
                        noremap ' o
                        noremap " O

                        noremap h <Nop>
                        noremap j <Nop>
                        noremap k <Nop>
                        noremap l <Nop>

                        " === Alternacive Escape Mapping ===
                        inoremap ne <Esc>
                        inoremap en <Esc>

                        " === Disable Netrw History ===
                        "let g:netrw_dirhistmax = 0

                        " === Disable Arrow Keys ===
                        noremap <Up> <Nop>
                        noremap <Down> <Nop>
                        noremap <Left> <Nop>
                        noremap <Right> <Nop>
                        inoremap <Up> <Nop>
                        inoremap <Down> <Nop>
                        inoremap <Left> <Nop>
                        inoremap <Right> <Nop>'';
                };
                newsboat = {
                    enable = true;
                    browser = "/etc/profiles/per-user/soma/bin/mpv";
                    extraConfig = ''
                        # === Color ===
                        color listfocus black white
                        color listfocus_unread black white bold
                        color title black black
                        color info black black

                        # === Filter ===
                        ignore-mode "display"
                        ignore-article "*" "title =~ \"#shorts\""
                        ignore-article "*" "link =~ \"shorts\""

                        # === Summary ===
                        macro a set browser "yt-dlp --write-auto-sub -q --no-warnings --skip-download -o /tmp/sub %u ; sed '1,4d; /^[0-9]\\{2\\}:/d; s/<[^>]*>//g; s/&gt;//g' /tmp/sub.en.vtt | awk 'NF' | uniq | tr '\n' ' ' | aichat Summarize the YouTube video. Do not mention filler. | less" ; open-in-browser ; set browser /etc/profiles/per-user/soma/bin/mpv
                    '';
                };
                yt-dlp = {
                    enable = true;
                    settings = {
                        embed-chapters = true;
                        embed-metadata = true;
                        embed-subs = true;
                        embed-thumbnail = true;
                        format-sort = "res:1080";
                        no-warnings = true;
                        progress = true;
                        sponsorblock-remove = "all";
                        sub-langs = "en";
                    };
                };
                zathura = {
                    enable = true;
                    mappings = {
                        # === Scroll ===
                        "w" = "scroll up";
                        "a" = "scroll left";
                        "r" = "scroll down";
                        "s" = "scroll right";

                        "m" = "scroll left";
                        "n" = "scroll down";
                        "e" = "scroll up";
                        "i" = "scroll right";

                        "u" = "scroll full-up";
                        "l" = "scroll full-down";

                        # === Zoom ===
                        "t" = "zoom in";
                        "d" = "zoom out";

                        # === Adjust ===
                        "c" = "adjust_window width";
                        "D" = "toggle_page_mode";
                        "R" = "rotate";

                        # === Search ===
                        "E" = "search backward";
                        "N" = "search forward";

                        # === Delete ===
                        "<BackSpace>" = "exec \"gtrash put '$FILE'\"";
                    };
                    options = {
                        recolor = true;
                        selection-clipboard = "clipboard";
                        selection-notification = false;
                    };
                };
            };
            services = {
                batsignal = {
                    enable = true;
                    extraArgs = ["-D systemctl suspend-then-hibernate"];
                };
                mako = {
                    enable = true;
                    settings = {
                        background-color = "#000000BF";
                        border-color = "#AAAAAABF";
                        default-timeout = 5000;
                        layer = "overlay";
                    };
                };
                tldr-update.enable = true;
                wl-clip-persist.enable = true;
                wlsunset = {
                    enable = true;
                    latitude = 47.5;
                    longitude = 19;
                    temperature.night = 2200;
                };
            };
            xdg = {
                enable = true;
                mimeApps = {
                    enable = true;
                    defaultApplications = {
                        "application/javascript" = "nvim.desktop";
                        "application/json" = "nvim.desktop";
                        "application/pdf" = "org.pwmt.zathura.desktop";
                        "application/rft" = "onlyoffice-desktopeditors.desktop";
                        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "onlyoffice-desktopeditors.desktop";
                        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "onlyoffice-desktopeditors.desktop";
                        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "onlyoffice-desktopeditors.desktop";
                        "application/x-bittorrent" = "transmission.desktop";
                        "application/xml" = "nvim.desktop";
                        "application/yaml" = "nvim.desktop";
                        "audio/aac" = "mpv.desktop";
                        "audio/flac" = "mpv.desktop";
                        "audio/mpeg" = "mpv.desktop";
                        "audio/ogg" = "mpv.desktop";
                        "audio/wav" = "mpv.desktop";
                        "image/jpeg" = "mpv.desktop";
                        "image/png" = "mpv.desktop";
                        "image/webp" = "mpv.desktop";
                        "text/css" = "nvim.desktop";
                        "text/html" = "librewolf.desktop";
                        "text/javascript" = "nvim.desktop";
                        "text/markdown" = "nvim.desktop";
                        "text/plain" = "nvim.desktop";
                        "text/x-python" = "nvim.desktop";
                        "text/x-sh" = "nvim.desktop";
                        "video/mp4" = "mpv.desktop";
                        "video/mpeg" = "mpv.desktop";
                        "video/quicktime" = "mpv.desktop";
                        "video/webm" = "mpv.desktop";
                        "video/x-matroska" = "mpv.desktop";
                        "x-scheme-handler/about" = "librewolf.desktop";
                        "x-scheme-handler/http" = "librewolf.desktop";
                        "x-scheme-handler/https" = "librewolf.desktop";
                        "x-scheme-handler/mailto" = "electron-mail.desktop";
                        "x-scheme-handler/unknown" = "librewolf.desktop";
                    };
                };
                portal = {
                    enable = true;
                    extraPortals = [pkgs.xdg-desktop-portal-gtk];
                    config.common.default = ["gtk"];
                };
                userDirs = {
                    enable = true;
                    desktop = "~/ar";
                    documents = "~/dx";
                    download = "~/dn";
                    music = "~/mu";
                    pictures = "~/px";
                    videos = "~/vs";
                };
            };
            gtk = {
                enable = true;
                colorScheme = "dark";
            };
            qt = {
                enable = true;
                platformTheme.name = "gtk";
            };
            home = {
                file = {
                    dotpulse-cookie = {
                        enable = true;
                        force = true;
                        target = ".config/pulse/client.conf";
                        text = "cookie-file = ~/.config/pulse/cookie";
                    };
                    links = {
                        enable = true;
                        force = true;
                        source = "${nixos}/misc/.links";
                        target = ".links";
                    };
                    mime_handlers = {
                        enable = true;
                        force = true;
                        target = ".librewolf/default/handlers.json";
                        text = ''
                            {
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
                                    "application/rtf": {
                                        "action": 4,
                                        "extensions": [
                                            "rtf"
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
                };
                pointerCursor = {
                    enable = true;
                    name = "Vanilla-DMZ-AA";
                    package = pkgs.vanilla-dmz;
                    size = 24;
                    sway.enable = true;
                };
                preferXdgDirectories = true;
                stateVersion = "26.05";
            };
        };
    };
}
