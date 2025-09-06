{
    config,
    pkgs,
    lib,
    ...
}: {
    home-manager.users.soma.programs.librewolf.profiles.default.extensions.settings."uBlock0@raymondhill.net".settings = {
        advancedUserEnabled = true;
        contextMenuEnabled = false;
        externalLists = "https://divested.dev/blocklists/Fingerprinting.ubl";
        popupPanelSections = 31;
        selectedFilterLists = [
            "user-filters"
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "easylist"
            "adguard-generic"
            "adguard-mobile"
            "easyprivacy"
            "LegitimateURLShortener"
            "adguard-spyware"
            "adguard-spyware-url"
            "block-lan"
            "urlhaus-1"
            "curben-phishing"
            "plowe-0"
            "dpollock-0"
            "fanboy-cookiemonster"
            "ublock-cookies-easylist"
            "adguard-cookies"
            "ublock-cookies-adguard"
            "fanboy-social"
            "adguard-social"
            "fanboy-thirdparty_social"
            "easylist-chat"
            "easylist-newsletters"
            "easylist-notifications"
            "easylist-annoyances"
            "adguard-mobile-app-banners"
            "adguard-other-annoyances"
            "adguard-popup-overlays"
            "adguard-widgets"
            "ublock-annoyances"
            "HUN-0"
            "https://divested.dev/blocklists/Fingerprinting.ubl"
        ];
        dynamicFilteringString = ''
            no-csp-reports: * true
            no-large-media: behind-the-scene false
            no-large-media: duckduckgo.com false
            no-remote-fonts: * true
            no-remote-fonts: github.com false
            no-remote-fonts: monkeytype.com false
            * * 3p-frame block
            * * 3p-script block
            * cloudflare.com * noop
            boards.4chan.org * 3p-script noop
            bandcamp.com * 3p-script noop
            behind-the-scene * * noop
            behind-the-scene * 1p-script noop
            behind-the-scene * 3p noop
            behind-the-scene * 3p-frame noop
            behind-the-scene * 3p-script noop
            behind-the-scene * image noop
            behind-the-scene * inline-script noop
            elte.dkodaj.net * * noop
            elte.dkodaj.net * 3p-frame noop
            elte.dkodaj.net * 3p-script noop
            www.dropbox.com * 3p-frame noop
            www.dropbox.com * 3p-script noop
            www.etsy.com * 3p-frame noop
            www.etsy.com * 3p-script noop
            genius.com * 3p-script noop
            github.com githubassets.com * noop
            www.google.com * 3p-script noop
            www.hasznaltauto.hu * 3p-frame noop
            www.hasznaltauto.hu * 3p-script noop
            imgur.com * 3p-script noop
            www.jofogas.hu * 3p-script noop
            login.live.com * 3p-script noop
            monkeytype.com * * noop
            mynixos.com * 3p-script noop
            ncore.pro * 3p-frame noop
            ncore.pro * 3p-script noop
            ingatlan.com * 3p-frame noop
            ingatlan.com * 3p-script noop
            ebay.de * 3p-frame noop
            ebay.de * 3p-script noop
            amazon.de * 3p-frame noop
            amazon.de * 3p-script noop
            steampowered.com * 3p-frame noop
            steampowered.com * 3p-script noop
            www.gsmarena.com * 3p-frame noop
            www.gsmarena.com * 3p-script noop
            www.jofogas.hu * 3p-frame noop
            www.jofogas.hu * 3p-script noop
            www.patreon.com cloudflare.com * noop
            www.pinterest.com * 3p-script noop
            www.pornhub.com * 3p-script noop
            www.reddit.com * 3p-script noop
            www.reddit.com reddit.map.fastly.net * noop
            www.reddit.com redditstatic.com * noop
            rsf.org * 3p-frame noop
            rsf.org * 3p-script noop
            www.rt.com * 3p-frame noop
            www.rt.com * 3p-script noop
            booru.soyjak.st * 3p-frame noop
            booru.soyjak.st * 3p-script noop
            vocaroo.com * 3p-script noop
            x.com * 3p-script noop
            xhamster.com * 3p-script noop'';
        urlFilteringString = "";
        hostnameSwitchesString = "no-large-media: behind-the-scene false\nno-remote-fonts: * true\nno-csp-reports: * true\nno-remote-fonts: github.com false\nno-large-media: duckduckgo.com        false\nno-strict-blocking: rentry.co true\nno-remote-fonts: monkeytype.com false\nno-strict-blocking: mobee.hu true";
    };
}
