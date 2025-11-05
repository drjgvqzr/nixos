{
    config,
    pkgs,
    lib,
    ...
}: {
    home-manager.users.soma.programs.librewolf = {
        enable = true;
        policies.ExtensionSettings = {
            "redirector@einaregilsson.com" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/redirector/latest.xpi";
                installation_mode = "force_installed";
            };
            "addon@darkreader.org" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
                installation_mode = "force_installed";
            };
            "vimium-c@gdh1995.cn" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
                installation_mode = "force_installed";
            };
            "newtab-adapter@gdh1995.cn" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/newtab-adapter/latest.xpi";
                installation_mode = "force_installed";
            };
            "contact@example.com" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/smartreader/latest.xpi";
                installation_mode = "force_installed";
            };
            "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
                installation_mode = "force_installed";
            };
            "sponsorBlocker@ajay.app" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
                installation_mode = "force_installed";
            };
            "extraneous@sysrqmagician.github.io" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/extraneous/latest.xpi";
                installation_mode = "force_installed";
            };
        };
        profiles.default = {
            settings = {
                "browser.startup.page" = 3;
                "browser.startup.homepage" = "about:newtab";
                "browser.newtabpage.enabled" = false;
                "browser.download.open_pdf_attachments_inline" = true;
                "findbar.highlightAll" = true;
                "font.name.monospace.x-western" = "Roboto Mono";
                "font.name.sans-serif.x-western" = "Roboto Mono";
                "font.name.serif.x-western" = "Roboto Mono";
                "font.size.variable.x-western" = "18";
                "sidebar.verticalTabs" = true;
                "sidebar.expandOnHoverMessage.dismissed" = true;
                "sidebar.backupState" = "{\"command\":\"\",\"launcherWidth\":55,\"launcherExpanded\":false,\"launcherVisible\":true}";
                "sidebar.main.tools" = "aichat";
                "privacy.resistFingerprinting.letterboxing" = true;
                "privacy.clearOnShutdown.history" = false;
                "browser.download.useDownloadDir" = false;
                "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
                "browser.search.suggest.enabled" = true;
                "identity.fxaccounts.enabled" = true;
                "network.http.referer.XOriginPolicy" = 2;
                "browser.toolbars.bookmarks.visibility" = "never";
                "privacy.userContext.enabled" = false;
                "browser.bookmarks.editDialog.showForNewBookmarks" = false;
                "browser.download.autohideButton" = true;
                "browser.urlbar.suggest.engines" = false;
                "extensions.webextensions.ExtensionStorageIDB.enabled" = false;
                "librewolf.hidePasswdmgr" = true;
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                "ui.systemUsesDarkTheme" = 1;
                "network.protocol-handler.expose.magnet" = false;
                "widget.use-xdg-desktop-portal.file-picker" = 2;
                "privacy.trackingprotection.allow_list.baseline.enabled" = true;
                "privacy.trackingprotection.allow_list.convenience.enabled" = true;
                "xpinstall.signatures.required" = false;
                "browser.download.start_downloads_in_tmp_dir" = false;
                "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["sponsorblocker_ajay_app-browser-action","addon_darkreader_org-browser-action","vimium-c_gdh1995_cn-browser-action","extraneous_sysrqmagician_github_io-browser-action","redirector_einaregilsson_com-browser-action","contact_example_com-browser-action","_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action"],"nav-bar":["sidebar-button","back-button","forward-button","urlbar-container","downloads-button","ublock0_raymondhill_net-browser-action","unified-extensions-button","vertical-spacer"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["personal-bookmarks"]},"seen":["ublock0_raymondhill_net-browser-action","developer-button","screenshot-button","addon_darkreader_org-browser-action","vimium-c_gdh1995_cn-browser-action","extraneous_sysrqmagician_github_io-browser-action","redirector_einaregilsson_com-browser-action","contact_example_com-browser-action","_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action","sponsorblocker_ajay_app-browser-action"],"dirtyAreaCache":["unified-extensions-area","nav-bar","TabsToolbar","vertical-tabs","toolbar-menubar","PersonalToolbar"],"currentVersion":23,"newElementCount":7}'';
                "browser.uiCustomization.navBarWhenVerticalTabs" = ''["back-button","forward-button","urlbar-container","downloads-button","ublock0_raymondhill_net-browser-action","unified-extensions-button"]'';
            };
            isDefault = true;
            extensions.force = true;
            extensions.settings."addon@darkreader.org".settings = {
                theme = {
                    contrast = 150;
                };
                syncSettings = false;
                detectDarkTheme = false;
                changeBrowserTheme = true;
                enableForProtectedPages = true;
                disabledFor = ["boards.4chan.org"];
            };
            extensions.settings."extraneous@sysrqmagician.github.io".settings = {
                config = {
                    watched.enabled = false;
                    hideSlop = {
                        enabled = true;
                        badTitleRegex = "^.*#short.*$";
                        minDuration = "00:03:00";
                    };
                    deArrow = {
                        enabled = true;
                        trustedOnly = true;
                        highlightReplacedTitles = true;
                    };
                    additionalLinks.cobaltTools = false;
                };
            };
            userChrome = ''                /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/autohide_toolbox.css made available under Mozilla Public License v. 2.0
                See the above repository for updates as well as full license text. */

                /* Hide the whole toolbar area unless urlbar is focused or cursor is over the toolbar
                 * Dimensions on non-Win10 OS probably needs to be adjusted.
                 */

                :root{
                  --uc-autohide-toolbox-delay: 200ms; /* Wait 0.1s before hiding toolbars */
                  --uc-toolbox-rotation: 82deg;  /* This may need to be lower on mac - like 75 or so */
                }

                :root[sizemode="maximized"]{
                  --uc-toolbox-rotation: 88.5deg;
                }

                @media  (-moz-platform: windows){
                  :root:not([lwtheme]) #navigator-toolbox{ background-color: -moz-dialog !important; }
                }

                :root[sizemode="fullscreen"],
                :root[sizemode="fullscreen"] #navigator-toolbox{ margin-top: 0 !important; }

                #navigator-toolbox{
                  --browser-area-z-index-toolbox: 3;
                  position: fixed !important;
                  background-color: var(--lwt-accent-color,black) !important;
                  transition: transform 82ms linear, opacity 82ms linear !important;
                  transition-delay: var(--uc-autohide-toolbox-delay) !important;
                  transform-origin: top;
                  transform: rotateX(var(--uc-toolbox-rotation));
                  opacity: 0;
                  line-height: 0;
                  z-index: 1;
                  pointer-events: none;
                  width: 100vw;
                }
                :root[sessionrestored] #urlbar[popover]{
                  pointer-events: none;
                  opacity: 0;
                  transition: transform 82ms linear var(--uc-autohide-toolbox-delay), opacity 0ms calc(var(--uc-autohide-toolbox-delay) + 82ms);
                  transform-origin: 0px calc(0px - var(--tab-min-height) - var(--tab-block-margin) * 2);
                  transform: rotateX(89.9deg);
                }
                #mainPopupSet:has(> [panelopen]:not(#ask-chat-shortcuts,#selection-shortcut-action-panel,#chat-shortcuts-options-panel,#tab-preview-panel)) ~ toolbox #urlbar[popover],
                #navigator-toolbox:is(:hover,:focus-within,[movingtab]) #urlbar[popover],
                #urlbar-container > #urlbar[popover]:is([focused],[open]){
                  pointer-events: auto;
                  opacity: 1;
                  transition-delay: 33ms;
                  transform: rotateX(0deg);
                }
                #mainPopupSet:has(> [panelopen]:not(#ask-chat-shortcuts,#selection-shortcut-action-panel,#chat-shortcuts-options-panel,#tab-preview-panel)) ~ toolbox,
                #navigator-toolbox:has(#urlbar:is([open],[focus-within])),
                #navigator-toolbox:is(:hover,:focus-within,[movingtab]){
                  transition-delay: 33ms !important;
                  transform: rotateX(0);
                  opacity: 1;
                }
                /* This makes things like OS menubar/taskbar show the toolbox when hovered in maximized windows.
                 * Unfortunately it also means that other OS native surfaces (such as context menu on macos)
                 * and other always-on-top applications will trigger toolbox to show up. */
                @media (-moz-bool-pref: "userchrome.autohide-toolbox.unhide-by-native-ui.enabled"),
                       -moz-pref("userchrome.autohide-toolbox.unhide-by-native-ui.enabled"){
                  :root[sizemode="maximized"]:not(:hover){
                    #navigator-toolbox:not(:-moz-window-inactive),
                    #urlbar[popover]:not(:-moz-window-inactive){
                      transition-delay: 33ms !important;
                      transform: rotateX(0);
                      opacity: 1;
                    }
                  }
                }

                #navigator-toolbox > *{ line-height: normal; pointer-events: auto }

                /* Don't apply transform before window has been fully created */
                :root:not([sessionrestored]) #navigator-toolbox{ transform:none !important }

                :root[customizing] #navigator-toolbox{
                  position: relative !important;
                  transform: none !important;
                  opacity: 1 !important;
                }

                #navigator-toolbox[inFullscreen] > #PersonalToolbar,
                #PersonalToolbar[collapsed="true"]{ display: none }

                /* This is a bit hacky fix for an issue that will make urlbar zero pixels tall after you enter customize mode */
                #urlbar[breakout][breakout-extend] > .urlbar-input-container{
                  padding-block: calc(min(4px,(var(--urlbar-container-height) - var(--urlbar-height)) / 2) + var(--urlbar-container-padding)) !important;
                }

                /* Uncomment this if tabs toolbar is hidden with hide_tabs_toolbar.css */
                 /*#titlebar{ margin-bottom: -9px }*/

                /* Uncomment the following for compatibility with tabs_on_bottom.css - this isn't well tested though */
                /*
                #navigator-toolbox{ flex-direction: column; display: flex; }
                #titlebar{ order: 2 }
                */'';
        };
    };
}
