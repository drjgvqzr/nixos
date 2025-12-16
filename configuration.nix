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
        ./sway.nix
        ./misc/secrets.nix
        ./misc/thunderbird.nix
        ./misc/vimium.nix
        ./zsh.nix
        ./misc/uBlock.nix
        ./misc/redirector.nix
        #./misc/printing.nix
    ];
    environment.systemPackages = with pkgs; [
        #CLI
        alejandra
        any-nix-shell
        backgroundremover
        bat
        catdocx
        cointop
        cook-cli
        dash
        doxx
        exfatprogs
        fastfetch
        fbcat
        fd
        fdupes
        ffmpeg
        figlet
        fishPlugins.autopair
        fishPlugins.puffer
        fzf
        gallery-dl
        gh
        ghc
        glow
        gnumake
        gnupg
        grc
        groff
        gtrash
        handlr-regex
        hledger
        hyperfine
        iftop
        imagemagick
        inxi
        jmtpfs
        jq
        libnotify
        libqalculate
        lineselect
        links2
        mailsy
        mapscii
        ncdu
        nixos-anywhere
        nix-search-tv
        ocrmypdf
        openai-whisper
        ouch
        pandoc
        parted
        pastel
        pciutils
        pdftk
        percollate
        pipe-rename
        piper-tts
        pipe-viewer
        poppler-utils
        presenterm
        pulseaudio
        pulsemixer
        qrrs
        rclone
        ripgrep
        ripgrep-all
        rsync
        smartmontools
        sox
        speedread
        speedtest-go
        stc-cli
        stress
        sunwait
        surfraw
        ticker
        tickrs
        timer
        tldr
        toipe
        translate-shell
        transmission_4-gtk
        tree
        unoconv
        urban-cli
        wget
        when
        woeusb
        xdg-utils
        yq
        zbar

        #Wayland
        autotiling-rs
        brightnessctl
        grim
        hunspell
        hunspellDicts.en_US-large
        hunspellDicts.hu_HU
        hyprpicker
        i3-swallow
        perl540Packages.Apppapersway
        slurp
        swaybg
        swayidle
        swaylock
        wayprompt
        wev
        wf-recorder
        wl-clipboard-rs
        wmenu

        #GUI
        audacity
        firefox
        fluffychat
        gimp
        googleearth-pro
        kdePackages.kdenlive
        kdePackages.kolourpaint
        kdiskmark
        logseq
        #lutris
        mullvad-browser
        obs-studio
        onlyoffice-desktopeditors
        pavucontrol
        qdirstat
        shotwell
        #starsector # TEITW-HP9ON-A7HMK-WA6YA
        tor-browser
        ungoogled-chromium
        #unigine-heaven
        webcord
        xfce.thunar
        zotero
    ];
    boot = {
        kernelParams =
            if config.networking.hostName == "Mini"
            then ["fbcon=rotate:1" "video=DSI-1:panel_orientation=right_side_up"]
            else [];
        initrd = {
            checkJournalingFS = true;
            luks.devices."luks".allowDiscards = true;
            systemd.enable = true;
        };
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
            systemd-boot = {
                enable = true;
                configurationLimit =
                    if config.networking.hostName == "Mini"
                    then 500
                    else 1;
            };
            efi.canTouchEfiVariables = true;
            timeout = 0;
        };
    };
    console.useXkbConfig = true;
    environment = {
        binsh = "${pkgs.dash}/bin/dash";
        defaultPackages = [];
        pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
        shells = with pkgs; [fish];
        sessionVariables = {
            BROWSER = "xdg-open";
            EDITOR = "nvim";
            GIT_PAGER = "less -R";
            LEDGER_FILE = "$HOME/dx/Backups/finance/2025.journal";
            MANPAGER = "nvim +Man!";
            PAGER = "nvim -R +AnsiEsc";
            XDG_CACHE_HOME = "$HOME/.cache";
            XDG_CONFIG_HOME = "$HOME/.config";
            XDG_DATA_HOME = "$HOME/.local/share";
            XDG_STATE_HOME = "$HOME/.local/state";
            XDG_DESKTOP_DIR = "$HOME/dn";
            XDG_DOCUMENTS_DIR = "$HOME/dx";
            XDG_DOWNLOAD_DIR = "$HOME/dn";
            XDG_MUSIC_DIR = "$HOME/mu";
            XDG_PICTURES_DIR = "$HOME/px";
            XDG_PUBLICSHARE_DIR = "$HOME/dn";
            XDG_TEMPLATES_DIR = "$HOME/dn";
            XDG_VIDEOS_DIR = "$HOME/vs";
        };
    };
    fonts = {
        fontDir.enable = true;
        #packages = with pkgs; [roboto-mono noto-fonts-color-emoji unifont];
        packages = with pkgs; [roboto-mono unifont];
        fontconfig = {
            enable = true;
            defaultFonts = {
                monospace = ["Roboto Mono"];
                serif = ["Roboto Mono"];
                sansSerif = ["Roboto Mono"];
                emoji = ["Noto Color Emoji"];
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
    };
    i18n.defaultLocale = "en_US.UTF-8";
    networking = {
        enableIPv6 = false;
        extraHosts = "0.0.0.0 boards.4chan.org";
        dhcpcd.enable = false;
        hostName =
            if builtins.pathExists /sys/kernel/btf/thinkpad_acpi
            then "W520"
            else "Mini";
        nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
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
                Network.EnableIPv6 = false;
            };
        };
    };
    nix = {
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
        optimise = {
            automatic = true;
            dates = ["monthly"];
        };
    };
    nixpkgs.config = {
        permittedInsecurePackages = [
            "googleearth-pro-7.3.6.10201"
        ];
        allowUnfreePredicate = pkg:
            builtins.elem (lib.getName pkg) [
                "googleearth-pro"
                #"steam"
                #"steam-unwrapped"
                #"unigine-heaven"
            ];
    };
    programs = {
        adb.enable = true;
        bash.shellInit = "export HISTFILE=/tmp/bash_history";
        command-not-found.enable = true;
        dconf.enable = true;
        fish.enable = true;
        firejail = {
            enable = true;
            wrappedBinaries = {
                # Sandbox a web browser
                librewolf = {
                    executable = "${lib.getBin pkgs.librewolf}/bin/librewolf";
                    profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
                };
            };
        };
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
        steam.enable = false;
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
        sleep.extraConfig = "HibernateDelaySec=1h";
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
        ollama = {
            enable = true;
            loadModels = ["deepseek-r1:1.5b"];
        };
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };
        playerctld.enable = true;
        resolved = {
            enable = true;
            dnssec = "true";
            domains = ["~."];
            fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
            dnsovertls = "true";
        };
        syncthing = {
            enable = true;
            dataDir = "/home/soma";
            group = "users";
            openDefaultPorts = true;
            user = "soma";
            cert = "/home/soma/dx/nixos/misc/secrets/${config.networking.hostName}_cert.pem";
            key = "/home/soma/dx/nixos/misc/secrets/${config.networking.hostName}_key.pem";
            settings = {
                devices = {
                    "W520".id = lib.strings.trim (builtins.readFile /home/soma/dx/nixos/misc/secrets/W520_st-id);
                    "Mini".id = lib.strings.trim (builtins.readFile /home/soma/dx/nixos/misc/secrets/Mini_st-id);
                    "I3113".id = lib.strings.trim (builtins.readFile /home/soma/dx/nixos/misc/secrets/I3113_st-id);
                };
                folders = {
                    "ar" = {
                        path = "~/ar";
                        id = "ciwug-fwawa";
                        devices = [
                            "Mini"
                            "W520"
                        ];
                        versioning = {
                            type = "trashcan";
                            params.cleanoutDays = "30";
                        };
                    };
                    "dn" = {
                        path = "~/dn";
                        id = "eztfs-xg2pf";
                        devices = [
                            "Mini"
                            "W520"
                        ];
                        versioning = {
                            type = "trashcan";
                            params.cleanoutDays = "30";
                        };
                    };
                    "dx" = {
                        path = "~/dx";
                        id = "oh2oz-9t565";
                        devices = [
                            "Mini"
                            "W520"
                            "I3113"
                        ];
                        versioning = {
                            type = "trashcan";
                            params.cleanoutDays = "30";
                        };
                    };
                    "mu" = {
                        path = "~/mu";
                        id = "sytcm-5kzcc";
                        devices = [
                            "Mini"
                            "W520"
                            "I3113"
                        ];
                        versioning = {
                            type = "trashcan";
                            params.cleanoutDays = "30";
                        };
                    };
                    "ph" = {
                        path = "~/ph";
                        id = "domno-sd3ps";
                        devices = [
                            "Mini"
                            "W520"
                            "I3113"
                        ];
                        versioning = {
                            type = "trashcan";
                            params.cleanoutDays = "30";
                        };
                    };
                    "px" = {
                        path = "~/px";
                        id = "d0ind-uzt2e";
                        devices = [
                            "Mini"
                            "W520"
                        ];
                        versioning = {
                            type = "trashcan";
                            params.cleanoutDays = "30";
                        };
                    };
                    "vs" = {
                        path = "~/vs";
                        id = "7sr22-b5ui1";
                        devices = [
                            "Mini"
                            "W520"
                        ];
                        versioning = {
                            type = "trashcan";
                            params.cleanoutDays = "30";
                        };
                    };
                };
            };
        };
        thermald.enable = true;
        vnstat.enable = true;
        xserver = {
            xkb.layout = "us";
            xkb.variant = "colemak_dh";
            xkb.options = "caps:backspace";
            exportConfiguration = true;
        };
    };
    time.timeZone = "Europe/Budapest";
    users = {
        defaultUserShell = pkgs.fish;
        users.soma = {
            isNormalUser = true;
            extraGroups = [
                "wheel"
                "adbusers"
            ];
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
                clients = [
                    {
                        type = "openai-compatible";
                        name = "openrouter";
                        api_base = "https://openrouter.ai/api/v1";
                        api_key = lib.strings.trim (builtins.readFile /home/soma/dx/nixos/misc/secrets/openrouter);
                        models = [
                            {
                                name = "deepseek/deepseek-v3.2";
                                system_prompt_prefix = lib.strings.trim (builtins.readFile /home/soma/dx/nixos/misc/ai_sysprompt);
                            }
                            {
                                name = "qwen/qwen3-embedding-8b";
                                type = "embedding";
                            }
                        ];
                    }
                    {
                        type = "openai-compatible";
                        name = "ollama";
                        api_base = "http://localhost:11434/v1";
                        models = [
                            {
                                name = "deepseek-r1:1.5b";
                                system_prompt_prefix = lib.strings.trim (builtins.readFile /home/soma/dx/nixos/misc/ai_sysprompt);
                            }
                        ];
                    }
                ];
                save = true;
                save_session = false;
                wrap = "auto";
                wrap_code = true;
                keybindings = "vi";
                rag_embedding_model = "openrouter:qwen/qwen3-embedding-8b";
                rag_chunk_size = 1000;
                rag_chunk_overlap = 50;
                document_loaders = {
                    pdf = "pdftotext $1 -";
                    epub = "pandoc --to plain $1";
                    docx = "pandoc --to plain $1";
                    odt = "pandoc --to plain $1";
                    pptx = "sh -c \"unoconv -d presentation -f pdf --stdout $1 |pdftotext - -\"";
                };
            };
        };
        programs.dircolors.enable = true;
        programs.fish = {
            enable = true;
            functions = {
                fish_prompt = "string join '' -- (set_color red) '%' (set_color white)  (prompt_pwd --dir-length=0) (set_color green) '>' (set_color normal)";
                fish_mode_prompt = "";
                s = ''links "https://lite.duckduckgo.com/lite/?q=$argv"'';
                sdh = ''links "https://lite.duckduckgo.com/lite/?q=$argv&kl=hu-hu"'';
                sud = ''links "https://rd.vern.cc/define.php?term=$argv"'';
                sg = ''links "https://github.com/search?q=$argv&s=stars"'';
                w = ''links "https://en.wikipedia.org/wiki/$argv?useskin=minerva#bodyContent"'';
                we = ''links "https://en.wiktionary.org/wiki/$argv#English"'';
                pb = ''links "https://thepiratebay.party/search/$argv"'';
                ay = ''
                    yt-dlp --write-auto-sub -q --no-warnings --skip-download -o /tmp/sub $(wl-paste | sed 's|inv.nadeko.net|youtube.com|');
                    cat /tmp/sub.en.vtt|
                    sed -e '/^[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}\.[0-9]\{3\} -->/d' -e '/^[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}\.[0-9]\{3\}/d' -e 's/<[^>]*>//g'|
                    awk 'NF'|
                    uniq -d|
                    sed 's/$/ /'|
                    tr -d '\n'|
                    aichat "give a detailed summary of the previous text with the main points. Do not mention any promotions or sponsors."'';
                "4" = ''
                    curl -sL $(wl-paste)|
                    grep -o 'is2.4chan.org[^"]*webm'|
                    uniq|
                    sed s.^.https://.|
                    mpv --playlist=-'';
                "4d" = ''
                    curl -sL $(wl-paste)|
                    grep -o 'is2.4chan.org[^"]*webm'|
                    uniq|
                    sed s.^.https://.|
                    xargs -I {} wget -nc -P ~/Videos/$argv[1] {}'';
                bcnp = ''
                    bluetoothctl power on
                    set btexists $(pgrep -f bluetoothctl)
                    [[ -z $btexists ]] && bluetoothctl -t 60 scan on > /dev/null &
                    watch -c -n 1 "bluetoothctl devices| grep Device | grep -v '.*-.*-.*-.*-.*-.*' | sort"
                    set selected $(bluetoothctl devices | grep Device | grep -v '.*-.*-.*-.*-.*-.*' | sort | fzf | cut -d' ' -f2)
                    bluetoothctl pair $selected
                    bluetoothctl connect $selected'';
                bcn = ''
                    bluetoothctl power on
                    set btexists $(pgrep -f bluetoothctl)
                    [[ -z $btexists ]] && bluetoothctl -t 60 scan on > /dev/null &
                    watch -c -n 1 "bluetoothctl devices| grep Device | grep -v '.*-.*-.*-.*-.*-.*' | sort"
                    bluetoothctl devices | grep Device | grep -v '.*-.*-.*-.*-.*-.*' | sort | fzf | cut -d' ' -f2 | xargs -I {} bluetoothctl connect {}'';
                bdcn = ''bluetoothctl devices Connected | grep Device | sort | fzf | cut -d' ' -f2 | xargs -I {} bluetoothctl disconnect {}'';
                bcnf = ''bluetoothctl devices Paired | grep Device | sort | fzf | cut -d' ' -f2 | xargs -I {} bluetoothctl remove {}'';
                sn = ''iwctl station wlan0 scan;iwctl station wlan0 get-networks'';
                cn = ''
                    watch -c -n 1 "iwctl station wlan0 scan ; iwctl station wlan0 get-networks"
                    set ssid $(iwctl station wlan0 get-networks | fzf --ansi |sed -e 's/ \{10,\}.*//' -e 's/^[[:space:]]*//')
                    read -r "?Password: " password
                    iwctl --passphrase="$password" station wlan0 connect "$ssid"'';
                cnf = ''
                    set ssid $(iwctl known-networks list | fzf --ansi |sed -e 's/ \{10,\}.*//' -e 's/^[[:space:]]*//')
                    iwctl known-networks $ssid forget'';
                nformat = ''
                    [ "$(pwd)" = "/mnt" ] && cd ~
                        ls /mnt 2>/dev/null || doas mkdir -p /mnt
                        doas umount /mnt 2>/dev/null;
                        doas cryptsetup close sd"$argv[1]"1 2>/dev/null;
                        doas parted -s /dev/sd"$argv[1]" mklabel msdos;
                        doas parted -s /dev/sd"$argv[1]" mkpart primary 0% 100%;
                        doas cryptsetup luksFormat -q /dev/sd"$argv[1]"1;
                        doas cryptsetup open /dev/sd"$argv[1]"1 sd"$argv[1]"1;
                        doas mkfs.ext4 -q /dev/mapper/sd"$argv[1]"1;
                        doas mount /dev/mapper/sd"$argv[1]"1 /mnt/;
                        doas rm -r /mnt/lost+found
                        doas chown -R "$USER":users /mnt/;
                        cd /mnt;'';
                format = ''
                    [ "$(pwd)" = "/mnt" ] && cd ~
                        ls /mnt 2>/dev/null || doas mkdir -p /mnt
                        doas umount /mnt 2>/dev/null;
                        doas cryptsetup close sd"$argv[1]"1 2>/dev/null;
                        doas parted -s /dev/sd"$argv[1]" mklabel msdos;
                        doas parted -s /dev/sd"$argv[1]" mkpart primary 0% 100%;
                        doas mkfs.ext4 -q /dev/sd"$argv[1]"1 &>/dev/null;
                        doas mount /dev/sd"$argv[1]"1 /mnt/;
                        doas rm -r /mnt/lost+found
                        doas chown -R "$USER":users /mnt/;
                        cd /mnt;'';
                wformat = ''
                    [ "$(pwd)" = "/mnt" ] && cd ~
                        ls /mnt 2>/dev/null || doas mkdir -p /mnt
                        doas umount /mnt 2>/dev/null;
                        doas parted -s /dev/mmcblk0 mklabel msdos;
                        doas parted -s /dev/mmcblk0 mkpart primary 0% 100%;
                        doas mkfs.ext4 -q /dev/mmcblk0p1 &>/dev/null;
                        doas mount /dev/mmcblk0p1 /mnt/;
                        doas rm -r /mnt/lost+found
                        doas chown -R "$USER":users /mnt/;
                        cd /mnt;'';
                wmnt = ''
                    [ "$(pwd)" = "/mnt" ] && cd ~
                        ls /mnt 2>/dev/null || doas mkdir -p /mnt
                        doas umount /mnt 2>/dev/null;
                        doas mount /dev/mmcblk0p1 /mnt/;
                        doas chown -R "$USER":users /mnt/;
                        cd /mnt;'';
                wumnt = ''
                    [ "$(pwd)" = "/mnt" ] && cd ~
                        ls /mnt 2>/dev/null || doas mkdir -p /mnt
                        doas umount /mnt/;'';
                formatcomp = ''
                    [ "$(pwd)" = "/mnt" ] && cd ~
                        ls /mnt 2>/dev/null || doas mkdir -p /mnt
                        doas umount /mnt 2>/dev/null;
                        doas cryptsetup close sd"$argv"1 2>/dev/null;
                        doas parted -s /dev/sd"$argv" mklabel msdos;
                        doas parted -s /dev/sd"$argv" mkpart primary 0% 100%;
                        doas parted /dev/sd"$argv" type 1 07;
                        doas mkfs.exfat -q /dev/sd"$argv"1 &>/dev/null;
                        doas mount /dev/sd"$argv"1 /mnt/;
                        doas rm -r /mnt/lost+found
                        cd /mnt;'';
                mnt = ''
                    [ "$(pwd)" = "/mnt" ] && cd ~
                        ls /mnt 2>/dev/null || doas mkdir -p /mnt
                        doas umount /mnt 2>/dev/null;
                        doas cryptsetup close sd"$argv[1]"1 2>/dev/null;
                        doas cryptsetup open /dev/sd"$argv[1]"1 sd"$argv[1]"1 2>/dev/null;
                        doas mount /dev/mapper/sd"$argv[1]"1 /mnt/ 2>/dev/null || doas mount /dev/sd"$argv[1]"1 /mnt/;
                        doas chown -R "$USER":users /mnt/;
                        cd /mnt;'';
                umnt = ''
                    [ "$(pwd)" = "/mnt" ] && cd ~
                        ls /mnt 2>/dev/null || doas mkdir -p /mnt
                        doas umount /mnt/;
                        doas cryptsetup close sd"$argv[1]"1 2>/dev/null;'';
                rebuild = ''
                    set nixos_dir ~/dx/nixos
                    alejandra --experimental-config /home/soma/dx/nixos/misc/alejandra.toml --quiet $nixos_dir
                    git -C $nixos_dir diff --quiet '*.nix' &&
                        echo "No changes detected, exiting." &&
                        return 1
                    git -C $nixos_dir diff --color=always -U0 '*.nix' | tail -n +5
                    echo "NixOS Rebuilding..."
                    doas nice -n 19 nixos-rebuild switch &> $nixos_dir/misc/nixos-switch.log && {
                      set generation $(git -C $nixos_dir diff -U20 HEAD '*.nix' | aichat summarize what changed in my nixos config in one short sentence | sed 's/.$//' )
                      git -C $nixos_dir commit -q -am $generation
                      git -C $nixos_dir push -q -u origin main
                      echo "$generation"
                      notify-send -e -t 5000 "Rebuild successful"
                    } || {
                      cat $nixos_dir/misc/nixos-switch.log | grep -i --color error | tail -n 1
                      notify-send -e -t 5000 "Rebuild Failed"
                      return 1
                      }'';
                rebuildu = ''
                    set nixos_dir ~/dx/nixos
                    alejandra --experimental-config /home/soma/dx/nixos/misc/alejandra.toml --quiet $nixos_dir
                    git -C $nixos_dir diff -U0 '*.nix'
                    echo "NixOS Rebuilding..."
                    doas nice -n 19 nixos-rebuild switch &> $nixos_dir/misc/nixos-switch.log && {
                        set generation $(git -C $nixos_dir diff -U20 HEAD '*.nix' | aichat summarize what changed in my nixos config in one short sentence | sed 's/.$//' )
                        git -C $nixos_dir commit -q -am $generation
                        git -C $nixos_dir push -q -u origin main
                        echo "\n$generation"
                        notify-send -e -t 5000 "Rebuild successful"
                    } || {
                        cat $nixos_dir/misc/nixos-switch.log | grep --color error | tail -n 1
                        notify-send -e -t 5000 "Rebuild Failed"
                        return 1
                    }'';
                pdfr = ''
                    pdftk $argv[1] cat 1-end"$argv[2]" output $(echo "$argv[1]" | sed 's/\.[^.]*$//')-"$argv[2]".pdf'';
                cb = ''curl -F "reqtype=fileupload" -F "time=72h" -F "fileToUpload=@$argv" https://litterbox.catbox.moe/resources/internals/api.php | wl-copy ; notify-send "File uploaded"'';
            };
            shellAbbrs = {
                "8" = "cd -";
                "9" = "cd ..";
                d = "doas";
                q = "qalc";
                o = "handlr open";
                f = "yazi";
                qr = "qrrs";
                cr = "cook r (fd cook ~/dx/Backups/cook | fzf )";
                h = "hledger";
                ha = "hledger add";
                mc = "man configuration.nix";
                mh = "man home-configuration.nix";
                z = "zathura";
                nb = "newsboat";
                nsp = "nix-shell -p";
                nt = "ping google.com";
                cdcook = "cd ~/dx/Backups/cook";
                nr = "doas systemctl restart iwd.service wg-quick-wg0.service";
                y = "pipe-viewer";
                tempmail = "mailsy";
                yd = "yt-dlp";
                yda = "yt-dlp -x";
                ydap = "yt-dlp -x -o \"%(playlist_index)s - %(title)s.%(ext)s\"";
                mkexec = "chmod +x";
                nrs = "rebuild";
                nrst = "tail -c +0 -f ~/dx/nixos/misc/nixos-switch.log";
                nrsv = "vi ~/dx/nixos/misc/nixos-switch.log";
                nrsu = "rebuildu";
                nconf = "vi ~/dx/nixos/configuration.nix";
                nconfl = "vi ~/dx/nixos/librewolf.nix";
                nconfs = "vi ~/dx/nixos/sway.nix";
                ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
                sw = "sway";
                gal = "shotwell";
                po = "poweroff";
                hn = "hibernate";
                rb = "reboot";
                la = "ls -A";
                ll = "ls -Al";
                lv = "ls -hpNFl --color";
                lt = "ls -hpNFltr --color";
                lS = "ls -hpNFlSr --color";
                tree = "tree --dirsfirst -CF";
                da = "date \"+%H:%M\"|figlet;cal";
                nf = "fastfetch";
                tra = "transmission-cli";
                #tra="transmission-cli $(wl-paste)";
                l = "links";
                v = "vi";
                m = "mpv";
                mt = "mpv --no-really-quiet";
                mtp = "mpv --no-really-quiet *";
                p = "mpv *";
                cdn = "cd ~/dn";
                cdx = "cd ~/dx";
                cdc = "cd ~/dx/nixos";
                b = "btop";
                wgu = "doas systemctl start wg-quick-wg0.service";
                wgd = "doas systemctl stop wg-quick-wg0.service";
                wgr = "doas systemctl restart wg-quick-wg0.service";
                mkd = "mkdir";
                lb = "lsblk";
                t = "trans";
                td = "trans :de";
                tm = "trans :hu";
                tr = "trans :ru";
                a = "aichat";
                as = "aichat -s";
                wa = "wl-paste | aichat";
                aex = "aichat -e";
                ax = "aichat explain";
                ae = "aichat give an example for";
                ad = "aichat what is the difference between";
                aw = "aichat provide the etymology, pronounciation without using phonetic symbols, meaning, and usage examples, all on new lines with markdown formatting, of the word";
            };
            shellAliases = {
                cdmnt = ''cd /mnt/'';
                "0" = "cd ~;clear";
                hibernate = "systemctl hibernate";
                #zathura = "swallow zathura";
                fastfetch = "fastfetch --logo nixos_old";
                "rec" = "pactl set-source-volume @DEFAULT_SOURCE@ 50% ; /run/current-system/sw/bin/rec -c 1 /home/soma/dx/Recordings/$(date \"+%Y-%m-%d %H.%M.%S\").ogg";
                irec = "ffmpeg -ac 1 -f pulse -i record_sink.monitor /home/soma/dx/Recordings/$(date \"+%Y-%m-%d %H.%M.%S\").ogg";
                qalc = "qalc -c -s 'upxrates 1'";
                ls = "ls -hpNF --color";
                mv = "mv -vu";
                rm = "gtrash put";
                cat = "bat --pager less";
                trash = "gtrash restore";
                fontname = ''/run/current-system/sw/bin/ls /nix/var/nix/profiles/system/sw/share/X11/fonts | fzf | xargs -I {} fc-query /nix/var/nix/profiles/system/sw/share/X11/fonts/{} | grep '^\s\+family:' | cut -d'"' -f2'';
                trashinfo = "gtrash summary";
                newsboat = "newsboat -q -u /home/soma/dx/nixos/misc/newsboat";
                grep = "grep -i --color";
                mkdir = "mkdir -pv";
                mw = "mpv $(wl-paste)";
                head = "head -v";
                cp = "cp -rvp";
                cal = "cal -mw";
                wget = "wget -c --hsts-file=~/.cache/wget-hsts";
                rename = "rename -iv";
                ln = "ln -ivP";
                chown = "chown -Rv";
                chmod = "chmod -Rv";
                shred = "shred -uvf -n 1 --remove=wipe";
                wttr = "curl https://wttr.in/budapest;sunwait list 47.62344395N 19.04990553124715E";
                speedtest = "speedtest-go -u decimal-bytes";
                trans = "echo ; /run/current-system/sw/bin/trans -b -j";
                diff = "grc --colour on diff";
                du = "grc --colour=auto du -h";
                env = "grc --colour=auto env";
                lsblk = "grc --colour=auto lsblk -n -o NAME,FSTYPE,SIZE,MOUNTPOINT";
                lsmod = "grc --colour=auto lsmod";
                lspci = "grc --colour=auto lspci";
                make = "grc --colour=auto make";
                ping = "grc --colour=auto ping";
                stat = "grc --colour=auto stat";
            };
            shellInit = ''
                set fish_color_command green
                set fish_greeting
                set -g fish_key_bindings fish_vi_key_bindings

                set fish_cursor_default block blink
                set fish_cursor_insert underscore blink
                set fish_cursor_replace_one line blink
                set fish_cursor_replace line blink
                set fish_cursor_external line blink
                set fish_cursor_visual block blink

                bind m backward-char
                bind n down-or-search
                bind e up-or-search
                bind i forward-char

                bind -M visual m backward-char
                bind -M visual n down-line
                bind -M visual e up-line
                bind -M visual i forward-char

                bind \' "set fish_bind_mode insert"
                bind \" beginning-of-line "set fish_bind_mode insert"

                set TTY1 (tty)
                [ "$TTY1" = "/dev/tty1" ] && exec sway

                set -q LS_AFTER_CD || set -xg LS_AFTER_CD true
                function __ls_after_cd__on_variable_pwd --on-variable PWD
                    if test "$LS_AFTER_CD" = true; and status --is-interactive
                        ls -hpNF --color
                    end
                end

                any-nix-shell fish | source

            '';
        };
        programs.foot = {
            enable = true;
            settings = {
                main = {
                    font = "Roboto Mono:size=14";
                    selection-target = "clipboard";
                    pad = "5x0";
                };
                bell.system = false;
                scrollback.lines = 100000;
                cursor.underline-thickness = "2px";
                mouse.hide-when-typing = true;
                colors = {
                    background = "000000";
                    foreground = "ffffff";
                    regular0 = "000000";
                    regular1 = "aa0000";
                    regular2 = "00aa00";
                    regular3 = "aa5500";
                    regular4 = "3333ff";
                    regular5 = "aa00aa";
                    regular6 = "00aaaa";
                    regular7 = "aaaaaa";
                    bright0 = "555555";
                    bright1 = "ff5555";
                    bright2 = "55ff55";
                    bright3 = "ffff55";
                    bright4 = "5555ff";
                    bright5 = "ff55ff";
                    bright6 = "55ffff";
                    bright7 = "ffffff";
                };
                key-bindings = {
                    clipboard-paste = "Control+v";
                    scrollback-up-page = "Control+Page_Up";
                    scrollback-down-page = "Control+Page_Down";
                    scrollback-home = "Control+Home";
                    scrollback-end = "Control+End";
                    show-urls-copy = "Control+y";
                    search-start = "Control+Shift+r";
                };
            };
        };
        programs.yazi = {
            enable = true;
            settings = {
                mgr = {
                    sort_by = "natural";
                    sort_sensitive = false;
                    sort_dir_first = true;
                    sort_translit = true;
                    show_symlink = true;
                };
            };
            initLua = ''
                require("full-border"):setup()
                require("no-status"):setup()'';
            keymap = {
                confirm.prepend_keymap = [
                    {
                        on = ["i"];
                        run = "close --submit";
                    }
                    {
                        on = ["m"];
                        run = "close";
                    }
                ];
                mgr.prepend_keymap = [
                    {
                        on = ["m"];
                        run = "leave";
                    }
                    {
                        on = ["n"];
                        run = "arrow 1";
                    }
                    {
                        on = ["e"];
                        run = "arrow -1";
                    }
                    {
                        on = ["i"];
                        run = "plugin smart-enter";
                    }
                    {
                        on = ["N"];
                        run = "find_arrow";
                    }
                    {
                        on = ["E"];
                        run = "find_arrow --previous";
                    }
                    {
                        on = ["k"];
                        run = "seek 5";
                    }
                    {
                        on = ["j"];
                        run = "seek -5";
                    }
                    {
                        on = ["C-["];
                        run = "escape";
                    }
                    {
                        on = ["q"];
                        run = "quit";
                    }
                    {
                        on = ["C-c"];
                        run = "close";
                    }
                    {
                        on = ["C-z"];
                        run = "suspend";
                    }
                ];
            };
        };
        programs.taskwarrior = {
            enable = true;
            config = {
                data.location = "/home/soma/dx/Backups/task";
                verbose = "blank,header,footnote,label,new-id,affected,edit,special,project,sync,override,recur";
            };
        };
        programs.mpv = {
            enable = true;
            config = {
                fullscreen = "yes";
                volume = "100";
                term-osd-bar-chars = "[/|\\]";
                gapless-audio = "yes";
                gpu-context = "wayland";
                image-display-duration = "inf";
                #audio-display = "no";
                msg-level = "vo/gpu=no,vo/ffmpeg=no,ffmpeg/demuxer=no";
                term-osd-bar = "yes";
                really-quiet = "yes";
                slang = "en,de";
                #ytdl-raw-options = "sub-langs=\"en,en-orig,de,hu\"";
                sid = "no";
                volume-max = "100";
                osd-font = "Roboto Mono";
                sub-font = "Roboto Mono";
            };
            scriptOpts = {
                stats.key_page_0 = "2";
                webtorrent.path = "/home/soma/tr/";
                sponsorblock_minimal.categories = "sponsor;selfpromo;interaction;intro;outro;preview;hook;music_offtopic;filler";
            };
            scripts = with pkgs.mpvScripts; [
                webtorrent-mpv-hook
                sponsorblock-minimal
                mpris
            ];
            bindings = {
                "a" = "add video-pan-x  +0.1";
                "s" = "add video-pan-x  -0.1";
                "w" = "add video-pan-y  +0.1";
                "r" = "add video-pan-y  -0.1";
                "R" = "cycle_values video-rotate 90 180 270 0";
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
            plugins = with pkgs.vimPlugins; [lightline-vim vim-plugin-AnsiEsc indentLine nvim-highlight-colors vim-plug];
            extraLuaConfig = ''
                vim.o.shada = ""
                require('nvim-highlight-colors').setup({})'';
            extraConfig = ''
                autocmd VimLeave * set guicursor=a:hor1-blinkwait500-blinkon250-blinkoff250
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
                "Plug 'luizribeiro/vim-cooklang', { 'for': 'cook' }
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
                noremap l e
                noremap N n
                noremap E N
                noremap ' i
                noremap " I
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
        services = {
            batsignal = {
                enable = true;
                extraArgs = ["-D systemctl suspend-then-hibernate" "-e"];
            };
            mako = {
                enable = true;
                settings = {
                    default-timeout = 5000;
                    background-color = "#0000007F";
                    border-color = "#AAAAAABF";
                };
            };
            tldr-update.enable = true;
            wl-clip-persist.enable = true;
            wlsunset = {
                enable = true;
                latitude = 47.5;
                longitude = 19;
                temperature.night = 3000;
            };
        };
        xdg = {
            enable = true;
            desktopEntries = {
                librewolf = {
                    name = "LibreWolf";
                    exec = "librewolf";
                };
                zathura = {
                    name = "Zathura";
                    exec = "zathura";
                };
                transmission = {
                    name = "Transmission";
                    exec = "transmission-cli -er -w /home/soma/tr";
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
                    "application/rft" = "onlyoffice-desktopeditors.desktop";
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
            style.name = "Adwaita-dark";
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
                "n" = "feedkeys <C-down>";
                "e" = "feedkeys <C-up>";
                "i" = "scroll right";
                "t" = "zoom in";
                "d" = "zoom out";
                "p" = "snap_to_page";
                "x" = "adjust_window best-fit";
                "c" = "adjust_window width";
                "E" = "search backward";
                "N" = "search forward";
                "D" = "toggle_page_mode";
                "u" = "navigate previous";
                "l" = "navigate next";
                "R" = "rotate";
            };
            options = {
                #guioptions = "vh";
                #adjust-open = "best-fit";
                #inputbar-bg = "#000000";
                #inputbar-fg = "#FFFFFF";
                recolor = "true";
                selection-clipboard = "clipboard";
            };
        };
        programs.newsboat = {
            enable = true;
            browser = "/etc/profiles/per-user/soma/bin/mpv";
            extraConfig = ''
                color listfocus black white
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
                net_iface = "wlan0";
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
                format-sort = "res:720";
                retries = "infinite";
                file-access-retries = "infinite";
                fragment-retries = "infinite";
                extractor-retries = "infinite";
                concurrent-fragments = 4;
                #quiet = true;
                progress = true;
                embed-subs = true;
                no-warnings = true;
                audio-quality = 0;
                #write-auto-subs = true;
                #sub-langs = "en,en-orig,de";
                sub-langs = "en";
                embed-chapters = true;
                embed-thumbnail = true;
                embed-metadata = true;
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
                dotpulse-cookie = {
                    enable = true;
                    force = true;
                    target = ".config/pulse/client.conf";
                    text = "cookie-file = ~/.config/pulse/cookie";
                };
                violentmonkey = {
                    enable = false;
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
                    enable = true;
                    force = true;
                    target = ".config/kitty/open-actions.conf";
                    text = ''
                        # Change directory in shell
                        protocol file
                        mime inode/directory
                        action launch --cwd=$FILE_PATH --type=overlay

                        #zathura swallow only from kitty
                        protocol file
                        mime application/pdf
                        action launch --type=overlay swallow zathura %u

                        #xdg-open
                        protocol file
                        *
                        action launch --type=overlay xdg-open
                    '';
                };
            };
        };
    };
}
