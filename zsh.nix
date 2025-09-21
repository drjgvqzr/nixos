{
    config,
    pkgs,
    lib,
    ...
}: {
    home-manager.users.soma.programs.zsh = {
        enable = true;
        envExtra = "setopt no_global_rcs";
        dotDir = "/home/soma/.config/zsh";
        history.path = "/home/soma/.config/zsh/.zsh_history";
        initContent = ''
            [[ $- != *i* ]] && return
            [[ "$(tty)" == /dev/tty1 ]] && sway
            autoload -U colors && colors    # Load colors
            PROMPT="%B%F{red}%#%f%F{white}%~%b%f%F{green}>%f"
            #RPROMPT="$(\date '+%m.%d.%u %H:%M')"
            RPROMPT="$(\date '+%H:%M')"

            setopt interactive_comments
            setopt nomatch
            set smartcase

            source <(gtrash completion zsh)
            sed -i 's/cmd => "\/nix\/store\/[^ ]*\/mpv/cmd => "\/etc\/profiles\/per-user\/soma\/bin\/mpv/g' /home/soma/.config/pipe-viewer/pipe-viewer.conf
            sed -i 's/--really-quiet --force-media-title=\*TITLE\* --no-ytdl \*VIDEO\*/\*URL\*/' /home/soma/.config/pipe-viewer/pipe-viewer.conf

            function reset_cursor() {
                printf '\e[3 q'  # Set cursor to underline
            }
            precmd_functions+=(reset_cursor)

            zstyle ':completion:*' menu select
            zmodload zsh/complist
            _comp_options+=(globdots)       # Include hidden files.
            zstyle ':completion::complete:*' use-cache 1
            [ -d cache/zsh ] || mkdir -p /home/soma/.cache/zsh
            zstyle ':completion:*' cache-path ~/.cache/zsh/completion.cache
            compinit -d .cache/zsh/zcompdump
            # Auto complete with case insenstivity
            zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
            #Fuzzy matching of completions for when you mistype them:
            zstyle ':completion:*' completer _complete _match _approximate
            zstyle ':completion:*:match:*' original only
            zstyle ':completion:*:approximate:*' max-errors 1 numeric
            #And if you want the number of errors allowed by _approximate to increase with the length of what you have typed so far:
            zstyle -e ':completion:*:approximate:*' \
            max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
            #Ignore completion functions for commands you don■t have:
            zstyle ':completion:*:functions' ignored-patterns '_*'
            #you can avoid having to complete at all in many cases, but if you do, you might want to fall into menu selection immediately and to have the words sorted by time:
            zstyle ':completion:*:*:xdvi:*' menu yes select
            zstyle ':completion:*:*:xdvi:*' file-sort time
            #If you end up using a directory as argument, this will remove the trailing slash (useful in ln)
            zstyle ':completion:*' squeeze-slashes true
            #cd will never select the parent directory (e.g.: cd ../<TAB>):
            zstyle ':completion:*:cd:*' ignore-parents parent pwd
            export TMOUT=3600 readonly TMOUT
            # Allow Ctrl-z to toggle between suspend and resume
            function Resume {
            fg
            zle push-input
            BUFFER=""
            zle accept-line
            }
            zle -N Resume
            bindkey "^Z" Resume

            eval "$(dircolors -b)"
            zstyle ':completion:*:default' list-colors 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.7z=01;31:*.ace=01;31:*.alz=01;31:*.apk=01;31:*.arc=01;31:*.arj=01;31:*.bz=01;31:*.bz2=01;31:*.cab=01;31:*.cpio=01;31:*.crate=01;31:*.deb=01;31:*.drpm=01;31:*.dwm=01;31:*.dz=01;31:*.ear=01;31:*.egg=01;31:*.esd=01;31:*.gz=01;31:*.jar=01;31:*.lha=01;31:*.lrz=01;31:*.lz=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.lzo=01;31:*.pyz=01;31:*.rar=01;31:*.rpm=01;31:*.rz=01;31:*.sar=01;31:*.swm=01;31:*.t7z=01;31:*.tar=01;31:*.taz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tgz=01;31:*.tlz=01;31:*.txz=01;31:*.tz=01;31:*.tzo=01;31:*.tzst=01;31:*.udeb=01;31:*.war=01;31:*.whl=01;31:*.wim=01;31:*.xz=01;31:*.z=01;31:*.zip=01;31:*.zoo=01;31:*.zst=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.jxl=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:'

            bindkey -s '^[[24~' '^udoas !!\n'
            bindkey -s '^[[23~' '!!| nvim -R +AnsiEsc\n'
            bindkey "^[[3~" delete-char
            bindkey "^[[1~" beginning-of-line
            bindkey "^[[H" beginning-of-line
            bindkey "^[[4~" end-of-line
            bindkey "^[[F" end-of-line
            bindkey "^[[6~" forward-word
            bindkey "^[[5~" backward-word
            bindkey "^[[2~" backward-delete-word
            bindkey -M menuselect ']' vi-backward-char
            bindkey -M menuselect 'm' vi-down-line-or-history
            bindkey -M menuselect 'n' vi-up-line-or-history
            bindkey -M menuselect 'e' vi-forward-char

            rehash
            clear
            setfont -d &> /dev/null

            ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
            ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *","mpv *"
            #ZSH_AUTOSUGGEST_COMPLETION_IGNORE="cd *","clear *","mpv *","nvim *"," *"
            ZSH_AUTOSUGGEST_MANUAL_REBIND=disable

            #  __                  _   _
            # / _|_   _ _ __   ___| |_(_) ___  _ __  ___
            #| |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
            #|  _| |_| | | | | (__| |_| | (_) | | | \__ \
            #|_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/


            auto-color-ls () {
            emulate -L zsh
            ls -hpNF --color --hyperlink=auto
            }
            chpwd_functions=(auto-color-ls $chpwd_functions)
            s () {links "https://lite.duckduckgo.com/lite/?q=$*"}
            sdh () {links "https://lite.duckduckgo.com/lite/?q=$*&kl=hu-hu"}
            sud () {links "https://rd.vern.cc/define.php?term=$*"}
            sg () {links "https://github.com/search?q=$*&s=stars"}
            w () {links "https://en.wikipedia.org/wiki/$*#bodyContent"}
            we () {links "https://en.wiktionary.org/wiki/$*#English"}
            ay () {
             yt-dlp --write-auto-sub -q --no-warnings --skip-download -o /tmp/sub $(wl-paste);
             cat /tmp/sub.en.vtt|
             sed -e '/^[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}\.[0-9]\{3\} -->/d' -e '/^[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}\.[0-9]\{3\}/d' -e 's/<[^>]*>//g'|
             awk 'NF'|
             uniq -d|
             sed 's/$/ /'|
             tr -d '\n'|
             aichat "give a detailed summary of the previous text with the main points. Do not mention any promotions or sponsors."
            }
            pb () {links "https://torrents-csv.com/search?q=$*"}
            4 () {
             curl -sL $(wl-paste)|
             grep -o 'is2.4chan.org[^"]*webm'|
             uniq|
             sed s.^.https://.|
             mpv --playlist=-
            }
            4d () {
             curl -sL $(wl-paste)|
             grep -o 'is2.4chan.org[^"]*webm'|
             uniq|
             sed s.^.https://.|
             xargs -I {} wget -nc -P ~/Videos/$1 {}
            }
            bcnp() {
                bluetoothctl power on
                [[ -z $(pgrep -f bluetoothctl) ]] && bluetoothctl -t 60 scan on > /dev/null &
                watch -c -n 1 "bluetoothctl devices| grep Device | grep -v '.*-.*-.*-.*-.*-.*' | sort"
                selected=$(bluetoothctl devices | grep Device | grep -v '.*-.*-.*-.*-.*-.*' | sort | fzf | cut -d' ' -f2)
                bluetoothctl pair $selected
                bluetoothctl connect $selected
            }
            bcn() {
                bluetoothctl power on
                [[ -z $(pgrep -f bluetoothctl) ]] && bluetoothctl -t 60 scan on > /dev/null &
                watch -c -n 1 "bluetoothctl devices| grep Device | grep -v '.*-.*-.*-.*-.*-.*' | sort"
                bluetoothctl devices | grep Device | grep -v '.*-.*-.*-.*-.*-.*' | sort | fzf | cut -d' ' -f2 | xargs -I {} bluetoothctl connect {}
            }
            bdcn() {
                bluetoothctl devices Connected | grep Device | sort | fzf | cut -d' ' -f2 | xargs -I {} bluetoothctl disconnect {}
            }
            bcnf() {
                bluetoothctl devices Paired | grep Device | sort | fzf | cut -d' ' -f2 | xargs -I {} bluetoothctl remove {}
            }
            sn () {iwctl station wlan0 scan;iwctl station wlan0 get-networks}
            cn() {
                watch -c -n 1 "iwctl station wlan0 scan ; iwctl station wlan0 get-networks"
                ssid=$(iwctl station wlan0 get-networks | fzf --ansi |sed -e 's/ \{10,\}.*//' -e 's/^[[:space:]]*//')
                read -r "?Password: " password
                iwctl --passphrase="$password" station wlan0 connect "$ssid"
            }
            cnf() {
                ssid=$(iwctl known-networks list | fzf --ansi |sed -e 's/ \{10,\}.*//' -e 's/^[[:space:]]*//')
                iwctl known-networks $ssid forget
            }
            #vi () {
            # if [ $(stat -c %U $1) = 'root' ]; then
            #  doas /etc/profiles/per-user/soma/bin/nvim "$@"
            # else
            #  /etc/profiles/per-user/soma/bin/nvim "$@"
            # fi
            #}
            nformat () {
              [ "$(pwd)" = "/mnt" ] && cd ~
                  ls /mnt 2>/dev/null || doas mkdir -p /mnt
                  doas umount /mnt 2>/dev/null;
                  doas cryptsetup close sd"$1"1 2>/dev/null;
                  doas parted -s /dev/sd"$1" mklabel msdos;
                  doas parted -s /dev/sd"$1" mkpart primary 0% 100%;
                  doas cryptsetup luksFormat -q /dev/sd"$1"1;
                  doas cryptsetup open /dev/sd"$1"1 sd"$1"1;
                  doas mkfs.ext4 -q /dev/mapper/sd"$1"1;
                  doas mount /dev/mapper/sd"$1"1 /mnt/;
                  doas chown -R "$USER":users /mnt/;
                  cd /mnt;
            }
            format () {
              [ "$(pwd)" = "/mnt" ] && cd ~
                  ls /mnt 2>/dev/null || doas mkdir -p /mnt
                  doas umount /mnt 2>/dev/null;
                  doas cryptsetup close sd"$1"1 2>/dev/null;
                  doas parted -s /dev/sd"$1" mklabel msdos;
                  doas parted -s /dev/sd"$1" mkpart primary 0% 100%;
                  doas mkfs.ext4 -q /dev/sd"$1"1 &>/dev/null;
                  doas mount /dev/sd"$1"1 /mnt/;
                  doas chown -R "$USER":users /mnt/;
                  cd /mnt;
            }
            wformat () {
              [ "$(pwd)" = "/mnt" ] && cd ~
                  ls /mnt 2>/dev/null || doas mkdir -p /mnt
                  doas umount /mnt 2>/dev/null;
                  doas parted -s /dev/mmcblk0 mklabel msdos;
                  doas parted -s /dev/mmcblk0 mkpart primary 0% 100%;
                  doas mkfs.ext4 -q /dev/mmcblk0p1 &>/dev/null;
                  doas mount /dev/mmcblk0p1 /mnt/;
                  doas chown -R "$USER":users /mnt/;
                  cd /mnt;
            }
            wmnt () {
              [ "$(pwd)" = "/mnt" ] && cd ~
                  ls /mnt 2>/dev/null || doas mkdir -p /mnt
                  doas umount /mnt 2>/dev/null;
                  doas mount /dev/mmcblk0p1 /mnt/;
                  doas chown -R "$USER":users /mnt/;
                  cd /mnt;
            }
            wumnt () {
              [ "$(pwd)" = "/mnt" ] && cd ~
                  ls /mnt 2>/dev/null || doas mkdir -p /mnt
                  doas umount /mnt/;
            }
            formatcomp () {
              [ "$(pwd)" = "/mnt" ] && cd ~
                  ls /mnt 2>/dev/null || doas mkdir -p /mnt
                  doas umount /mnt 2>/dev/null;
                  doas cryptsetup close sd"$1"1 2>/dev/null;
                  doas parted -s /dev/sd"$1" mklabel msdos;
                  doas parted -s /dev/sd"$1" mkpart primary 0% 100%;
                  doas parted /dev/sd"$1" type 1 07;
                  doas mkfs.exfat -q /dev/sd"$1"1 &>/dev/null;
                  doas mount /dev/sd"$1"1 /mnt/;
                  cd /mnt;
            }
            mnt () {
              [ "$(pwd)" = "/mnt" ] && cd ~
                  ls /mnt 2>/dev/null || doas mkdir -p /mnt
                  doas umount /mnt 2>/dev/null;
                  doas cryptsetup close sd"$1"1 2>/dev/null;
                  doas cryptsetup open /dev/sd"$1"1 sd"$1"1 2>/dev/null;
                  doas mount /dev/mapper/sd"$1"1 /mnt/ 2>/dev/null || doas mount /dev/sd"$1"1 /mnt/;
                  doas chown -R "$USER":users /mnt/;
                  cd /mnt;
            }
            umnt () {
              [ "$(pwd)" = "/mnt" ] && cd ~
                  ls /mnt 2>/dev/null || doas mkdir -p /mnt
                  doas umount /mnt/;
                  doas cryptsetup close sd"$1"1 2>/dev/null;
            }
            function command_not_found_handler() {
             local p='/run/current-system/sw/bin/command-not-found'
             if [ -x "$p" ] && [ -f '/nix/var/nix/profiles/per-user/root/channels/nixos/programs.sqlite' ]; then
             # Run the helper program.
             "$p" "$@"
             # Retry the command if we just installed it.
              if [ $? = 126 ]; then
               "$@"
              else
               return 127
              fi
             else
              # Indicate than there was an error so ZSH falls back to its default handler
              echo "$1: command not found" >&2
              return 127
             fi
            }
            cdmnt() {cd /mnt/}
            sca () {
              scanimage -p --format png --output-file $1
              mpv $1
            }
            nd () {
            git -C ~/dx/nixos diff HEAD~$1 HEAD
            }
            rebuild () {
              nixos_dir=~/dx/nixos
              alejandra --experimental-config /home/soma/dx/nixos/misc/alejandra.toml --quiet $nixos_dir
              git -C $nixos_dir diff --quiet '*.nix' &&
                  echo "No changes detected, exiting." &&
                  return 1
              git -C $nixos_dir diff -U0 '*.nix'
              echo "NixOS Rebuilding..."
              doas nice -n 19 nixos-rebuild switch &> $nixos_dir/misc/nixos-switch.log && {
                generation=$(git -C $nixos_dir diff -U20 HEAD | aichat summarize what changed in my nixos config in one short sentence | sed 's/.$//' )
                git -C $nixos_dir commit -q -am $generation
                git -C $nixos_dir push -q -u origin main
                echo "\n$generation"
                notify-send -e -t 5000 "Rebuild successful"
              } || {
                cat $nixos_dir/misc/nixos-switch.log | grep -i --color error | tail -n 1
                notify-send -e -t 5000 "Rebuild Failed"
                return 1
                }
            }
            rebuildu () {
                nixos_dir=~/dx/nixos
                alejandra --experimental-config /home/soma/dx/nixos/misc/alejandra.toml --quiet $nixos_dir
                git -C $nixos_dir diff -U0 '*.nix'
                echo "NixOS Rebuilding..."
                doas nice -n 19 nixos-rebuild switch &> $nixos_dir/misc/nixos-switch.log && {
                    generation=$(git -C $nixos_dir diff -U20 HEAD | aichat summarize what changed in my nixos config in one short sentence | sed 's/.$//' )
                    git -C $nixos_dir commit -q -am $generation
                    git -C $nixos_dir push -q -u origin main
                    echo "\n$generation"
                    notify-send -e -t 5000 "Rebuild successful"
                } || {
                    cat $nixos_dir/misc/nixos-switch.log | grep --color error | tail -n 1
                    notify-send -e -t 5000 "Rebuild Failed"
                    return 1
                }
            }
            tra ()  {
            doas systemctl stop wg-quick-wg0.service ;
            \transmission-cli -er -w /home/soma/tr/ $1 ;
            doas systemctl start wg-quick-wg0.service
            }
            #       _     _
            #  __ _| |__ | |__  _ __
            # / _` | '_ \| '_ \| '__|
            #| (_| | |_) | |_) | |
            # \__,_|_.__/|_.__/|_|

            abbrev-alias "8"="cd -"
            abbrev-alias "9"="cd .."
            abbrev-alias d="doas"
            abbrev-alias q="qalc"
            abbrev-alias z="zathura"
            abbrev-alias lo="libreoffice"
            abbrev-alias nb="newsboat"
            abbrev-alias nsp="nix-shell -p"
            abbrev-alias nt="ping google.com"
            abbrev-alias nr="doas systemctl restart iwd.service wg-quick-wg0.service"
            abbrev-alias y="pipe-viewer"
            abbrev-alias yd="yt-dlp"
            abbrev-alias pm="pulsemixer"
            abbrev-alias mkexec="chmod +x"
            abbrev-alias nrs="rebuild"
            abbrev-alias nrst="tail -c +0 -f ~/dx/nixos/misc/nixos-switch.log"
            abbrev-alias nrsv="vi ~/dx/nixos/misc/nixos-switch.log"
            abbrev-alias nrsu="rebuildu"
            abbrev-alias nconf="vi ~/dx/nixos/configuration.nix"
            abbrev-alias nconfl="vi ~/dx/nixos/librewolf.nix"
            abbrev-alias nconfs="vi ~/dx/nixos/sway.nix"
            abbrev-alias nconfz="vi ~/dx/nixos/zsh.nix"
            abbrev-alias ns="nix-search"
            abbrev-alias nsf="nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history"
            abbrev-alias sw="sway"
            abbrev-alias po="poweroff"
            abbrev-alias hn="hibernate"
            abbrev-alias rb="reboot"
            abbrev-alias la="ls -A"
            abbrev-alias ll="ls -Al"
            abbrev-alias lv="ls -hpNFl --color --hyperlink=auto"
            abbrev-alias lt="ls -hpNFltr --color --hyperlink=auto"
            abbrev-alias lS="ls -hpNFlSr --color --hyperlink=auto"
            abbrev-alias tree="tree --dirsfirst -CF"
            abbrev-alias da="date"
            abbrev-alias nf="fastfetch"
            #abbrev-alias tra="transmission-cli"
            #abbrev-alias tra="transmission-cli $(wl-paste)"
            abbrev-alias l="links"
            abbrev-alias v="vi"
            abbrev-alias m="mpv"
            abbrev-alias mt="mpv --no-really-quiet"
            abbrev-alias mtp="mpv --no-really-quiet *"
            abbrev-alias p="mpv *"
            abbrev-alias cdn="cd ~/dn"
            abbrev-alias cdx="cd ~/dx"
            abbrev-alias cdc="cd ~/dx/nixos"
            abbrev-alias b="btop"
            abbrev-alias untar="tar -xvf"
            abbrev-alias wgu="doas systemctl start wg-quick-wg0.service"
            abbrev-alias wgd="doas systemctl stop wg-quick-wg0.service"
            abbrev-alias wgr="doas systemctl restart wg-quick-wg0.service"
            abbrev-alias mkd="mkdir"
            abbrev-alias lb="lsblk"
            abbrev-alias t="trans"
            abbrev-alias td="trans :de"
            abbrev-alias tm="trans :hu"
            abbrev-alias tr="trans :ru"
            abbrev-alias a="aichat"
            abbrev-alias as="aichat -s"
            abbrev-alias wa="wl-paste | aichat"
            abbrev-alias aex="aichat -e"
            abbrev-alias ax="aichat explain"
            abbrev-alias ae="aichat give an example for"
            abbrev-alias ad="aichat what is the difference between"
            abbrev-alias aw="aichat provide the etymology, pronounciation without using phonetic symbols, meaning, and usage examples, all on new lines with markdown formatting, of the word"
        '';

        #       _ _
        #  __ _| (_) __ _ ___  ___  ___
        # / _` | | |/ _` / __|/ _ \/ __|
        #| (_| | | | (_| \__ \  __/\__ \
        # \__,_|_|_|\__,_|___/\___||___/

        shellAliases = {
            "0" = "cd ~;clear";
            hibernate = "systemctl hibernate";
            zathura = "swallow zathura";
            fastfetch = "fastfetch --logo nixos_old";
            unrar = "unrar-free";
            qalc = "qalc -c -s 'upxrates 1'";
            ls = "ls -hpNF --color --hyperlink=auto";
            mv = "mv -vu";
            rm = "gtrash put";
            rg = "rg --hyperlink-format=kitty";
            fd = "fd --hyperlink";
            trash = "gtrash restore";
            trashinfo = "gtrash summary";
            newsboat = "newsboat -q -u /home/soma/dx/nixos/misc/newsboat";
            ba = "echo $(cat /sys/class/power_supply/BAT0/capacity)%";
            grep = "grep --color";
            mkdir = "mkdir -pv";
            mw = "mpv $(wl-paste)";
            head = "head -v";
            cp = "cp -rvp";
            cal = "cal -mw";
            wget = "wget --hsts-file=~/.cache/wget-hsts";
            date = "date \"+%H:%M\"|figlet;cal";
            rename = "rename -iv";
            ln = "ln -ivP";
            lm = "echo -en \"\\e]P0aaaaaa\";echo -en \"\\e]P7000000\";clear";
            dm = "echo -en \"\\e]P0000000\";echo -en \"\\e]P7aaaaaa\";clear";
            chown = "chown -Rv";
            chmod = "chmod -Rv";
            wttr = "curl https://wttr.in/budapest;sunwait list 47.62344395N 19.04990553124715E";
            speedtest = "speedtest-go -u decimal-bytes";
            blkid = "grc --colour=on blkid";
            trans = "echo ; trans -b -j";
            df = "grc --colour=on df -h";
            diff = "grc --colour on diff";
            du = "grc --colour=on du -h";
            env = "grc --colour=on env";
            fdisk = "grc --colour=on fdisk";
            ifconfig = "grc --colour=on ifconfig";
            ip = "grc --colour=on ip";
            iptables = "grc --colour=on iptables";
            lsattr = "grc --colour=on lsattr";
            lsblk = "grc --colour=on lsblk -n -o NAME,FSTYPE,SIZE,MOUNTPOINT";
            lsmod = "grc --colour=on lsmod";
            lspci = "grc --colour=on lspci";
            make = "grc --colour=on make";
            mount = "grc --colour=on mount";
            netstat = "grc --colour=on netstat";
            ping = "grc --colour=on ping";
            ps = "grc --colour=on ps";
            stat = "grc --colour=on stat";
            sysctl = "grc --colour=on sysctl";
            traceroute = "grc --colour=on traceroute";
            uptime = "grc --colour=on uptime";
        };

        #       _             _
        # _ __ | |_   _  __ _(_)_ __  ___
        #| '_ \| | | | |/ _` | | '_ \/ __|
        #| |_) | | |_| | (_| | | | | \__ \
        #| .__/|_|\__,_|\__, |_|_| |_|___/
        #|_|            |___/

        syntaxHighlighting.enable = true;
        historySubstringSearch.enable = true;
        autosuggestion = {
            enable = true;
            strategy = [
                "history"
                "completion"
            ];
        };
        antidote = {
            enable = true;
            plugins = [
                "nix-community/nix-zsh-completions"
                "chisui/zsh-nix-shell"
                "momo-lab/zsh-abbrev-alias"
            ];
        };
    };
}
