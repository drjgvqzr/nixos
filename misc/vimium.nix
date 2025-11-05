{
    config,
    pkgs,
    lib,
    ...
}: {
    home-manager.users.soma.programs.librewolf.profiles.default.extensions.settings."vimium-c@gdh1995.cn".settings = {
        keyMappings = ''
            #!no-check
            unmapAll

            map m goBack
            map n scrollDown keepHover=false
            map e scrollUp keepHover=false
            map i goForward

            map l nextTab
            map u previousTab
            map L moveTabRight
            map U moveTabLeft
            map yt duplicateTab
            map x removeTab
            map X restoreTab

            map gi focusInput
            map gI LinkHints.activateEdit

            map f LinkHints.activate
            map F LinkHints.activateOpenInNewTab

            map / enterFindMode
            map N performFind
            map E performBackwardsFind


            map p openCopiedUrlInCurrentTab
            map P openCopiedUrlInNewTab

            map gg scrollToTop
            map G scrollToBottom

            map r reload
            map R reload hard

            map yf LinkHints.activateCopyLinkUrl
            map yy copyCurrentUrl
            map yi LinkHints.activateCopyImage

            map d LinkHints.activateDownloadImage
            map D LinkHints.activateDownloadLink

            map gu goUp
            map gU goToRoot

            map ]] goNext
            map [[ goPrevious

            map ' enterInsertMode

            ##map v enterVisualMode
            map V enterVisualLineMode
            map c LinkHints.activateSelect use caret
            map v LinkHints.activateSelect use visual
            mapkey <m:v> h
            mapkey <n:v> j
            mapkey <e:v> k
            mapkey <i:v> l

            map o Vomnibar.activate
            map O Vomnibar.activateInNewTab

            map b Vomnibar.activateBookmarks
            map B Vomnibar.activateBookmarksInNewTab

            map h Vomnibar.activateHistory
            map H Vomnibar.activateHistoryInNewTab

            map T Vomnibar.activateTabs

            map ge Vomnibar.activateEditUrl
            map gE Vomnibar.activateEditUrlInNewTab

            map gm toggleMuteTab all
            map gr toggleReaderMode

            ##map c zoomReset
            map ? showHelp
            map w reset

        '';
        searchEngines = ''
            w: https://en.wikipedia.org/wiki/%s Wikipedia
            y: https://inv.nadeko.net/search?q=%s Invidious
            ns: https://search.nixos.org/packages?channel=unstable&from=0&size=999&sort=relevance&type=packages&query=%s NixOS Packages
            nw: https://wiki.nixos.org/wiki/%s NixOS Wiki
            gm: https://www.google.com/maps?q=%s Google Maps
            gmn: https://www.google.com/maps/dir/$s{$1/$2} Google Maps Navigation
            g: https://www.google.com/search?q=%s Google
            az: https://www.amazon.de/s/?field-keywords=%s Amazon
            i: https://duckduckgo.com/?&q=%s&ia=images&iax=images Images
            h: https://lite.duckduckgo.com/lite/?&q=%s&kl=hu-hu Hungary
            gh: https://github.com/search?q=%s&type=repositories&s=stars&ref=opensearch Github
            ghg: https://gist.github.com/search?q=%s&ref=opensearch Github Gist
            ud: https://rd.vern.cc/define.php?term=%s Urban Dictionary
            pb: https://torrents-csv.com/search?q=%s Torrents
            we: https://en.wiktionary.org/wiki/%s#English Wiktionary
            r: https://www.reddit.com/search?q=%s Reddit
            sr: https://www.reddit.com/r/%s/top?t=all Subreddit
            fa: https://addons.mozilla.org/en-US/firefox/search/?q=%s Firefox Addons
            lib: https://annas-archive.org/search?q=%s
            elib: https://opac.elte.hu/Search/Results?lookfor=%s&type=AllFields
            aw: https://wiki.archlinux.org/title/%s
            gw: https://wiki.gentoo.org/wiki/%s
            jf: https://www.jofogas.hu/magyarorszag?q=%s
            ak: https://www.arukereso.hu/CategorySearch.php?st=%s
            eb: https://www.ebay.de/sch/i.html?_nkw=%s
            ph: https://www.pornhub.com/video/search?search=%s
            4: https://boards.4chan.org/%s/
            sh: javascript:location='https://sci-hub.st/https://'%20+%20escape(location.hostname%20+%20location.pathname)%20+%20'%20%S'%20;%20void%200
            4pol: https://archive.4plebs.org/pol/search/type/op/text/%s
            4g: https://desuarchive.org/g/search/type/op/text/%s/
            r34: https://rule34.xxx/index.php?page=post&s=list&tags=%s'';
        linkHintCharacters = "arstf";
        preferBrowserSearch = true;
        newTabUrl_f = "about:newtab";
        previousPatterns = "prev,previous,back,older,<,‹,←,«,≪,<<";
        nextPatterns = "next,more,newer,>,›,→,»,≫,>>";
        titleIgnoreList = "porn,4chan";
        omniBlockList = "porn,4chan";
    };
    home-manager.users.soma.programs.librewolf.profiles.default.search = {
        default = "lite";
        force = true;
        engines = {
            lite = {
                name = "lite";
                urls = [{template = "https://lite.duckduckgo.com/lite/?q={searchTerms}";}];
                definedAliases = ["@lite"];
            };
            wiki = {
                name = "Wikipedia";
                urls = [{template = "https://en.wikipedia.org/wiki/{searchTerms}";}];
                definedAliases = ["w"];
            };
            inv = {
                name = "Invidious";
                urls = [{template = "https://inv.nadeko.net/search?q={searchTerms}";}];
                definedAliases = ["y"];
            };
            images = {
                name = "Images";
                urls = [{template = "https://duckduckgo.com/?&q={searchTerms}&ia=images&iax=images";}];
                definedAliases = ["i"];
            };
            hun = {
                name = "Magyar";
                urls = [{template = "https://lite.duckduckgo.com/lite/?&q={searchTerms}&kl=hu-hu";}];
                definedAliases = ["m"];
            };
            github = {
                name = "Github";
                urls = [{template = "https://github.com/search?q={searchTerms}&type=repositories&s=stars";}];
                definedAliases = ["gh"];
            };
            githubgist = {
                name = "Github Gist";
                urls = [{template = "https://gist.github.com/search?q={searchTerms}&ref=opensearch";}];
                definedAliases = ["ghg"];
            };
            urbdict = {
                name = "Urban Dictionary";
                urls = [{template = "https://rd.vern.cc/define.php?term={searchTerms}";}];
                definedAliases = ["ud"];
            };
            pb = {
                name = "Torrents";
                urls = [{template = "https://torrents-csv.com/search?q={searchTerms}";}];
                definedAliases = ["pb"];
            };
            wiktionary = {
                name = "Wiktionary";
                urls = [{template = "https://en.wiktionary.org/wiki/{searchTerms}#English";}];
                definedAliases = ["we"];
            };
            reddit = {
                name = "Reddit";
                urls = [{template = "https://www.reddit.com/search?q={searchTerms}";}];
                definedAliases = ["r"];
            };
            subreddit = {
                name = "Subreddit";
                urls = [{template = "https://www.reddit.com/r/{searchTerms}/top?t=all";}];
                definedAliases = ["sr"];
            };
            pinterest = {
                name = "Pinterest";
                urls = [{template = "https://bn.bloat.cat/search.php?q={searchTerms}";}];
                definedAliases = ["p"];
            };
            maps = {
                name = "Google Maps";
                urls = [{template = "https://www.google.com/maps?q={searchTerms}";}];
                definedAliases = ["gm"];
            };
            google = {
                name = "Google";
                urls = [{template = "https://www.google.com/search?q={searchTerms}";}];
                definedAliases = ["g"];
            };
            amazon = {
                name = "Amazon";
                urls = [{template = "https://www.amazon.de/s/?field-keywords={searchTerms}";}];
                definedAliases = ["az"];
            };
            nixwiki = {
                name = "Nixos Wiki";
                urls = [{template = "https://wiki.nixos.org/wiki/{searchTerms}";}];
                definedAliases = ["nw"];
            };
            nixpkgs = {
                name = "Nixos Packages";
                urls = [{template = "https://search.nixos.org/packages?channel=unstable&from=0&size=999&sort=relevance&type=packages&query={searchTerms}";}];
                definedAliases = ["ns"];
            };
            addons = {
                name = "Firefox Addons";
                urls = [{template = "https://addons.mozilla.org/en-US/firefox/search/?q={searchTerms}";}];
                definedAliases = ["fa"];
            };
            library = {
                name = "Library";
                urls = [{template = "https://annas-archive.org/search?q={searchTerms}";}];
                definedAliases = ["lib"];
            };
            eltelibrary = {
                name = "Elte Könyvtár";
                urls = [{template = "https://opac.elte.hu/Search/Results?lookfor={searchTerms}&type=AllFields";}];
                definedAliases = ["elib"];
            };
            arch = {
                name = "Arch Wiki";
                urls = [{template = "https://wiki.archlinux.org/title/{searchTerms}";}];
                definedAliases = ["aw"];
            };
            gentoo = {
                name = "Gentoo Wiki";
                urls = [{template = "https://wiki.gentoo.org/wiki/{searchTerms}";}];
                definedAliases = ["gw"];
            };
            jofogas = {
                name = "Jófogás";
                urls = [{template = " https://www.jofogas.hu/magyarorszag?q={searchTerms}";}];
                definedAliases = ["jf"];
            };
            arukereso = {
                name = "Árukereső";
                urls = [{template = "https://www.arukereso.hu/CategorySearch.php?st={searchTerms}";}];
                definedAliases = ["ak"];
            };
            ebay = {
                name = "Ebay";
                urls = [{template = "https://www.ebay.de/sch/i.html?_nkw={searchTerms}";}];
                definedAliases = ["eb"];
            };
            pornhub = {
                name = "PornHub";
                urls = [{template = "https://www.pornhub.com/video/search?search={searchTerms}";}];
                definedAliases = ["ph"];
            };
            fourchan = {
                name = "4chan.org";
                urls = [{template = "https://boards.4chan.org/{searchTerms}";}];
                definedAliases = ["4"];
            };
            polarchive = {
                name = "/pol/ Archive";
                urls = [{template = "https://archive.4plebs.org/pol/search/type/op/text/{searchTerms}";}];
                definedAliases = ["4pol"];
            };
            garchive = {
                name = "/g/ Archive";
                urls = [{template = "https://desuarchive.org/g/search/type/op/text/{searchTerms}";}];
                definedAliases = ["4g"];
            };
            r34 = {
                name = "Rule 34";
                urls = [{template = "https://rule34.xxx/index.php?page=post&s=list&tags={searchTerms}";}];
                definedAliases = ["r34"];
            };
            bing.metaData.hidden = true;
            google.metaData.hidden = true;
            wikipedia.metaData.hidden = true;
            duckduckgo.metaData.hidden = true;
        };
    };
}
