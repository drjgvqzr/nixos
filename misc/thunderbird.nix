{
    config,
    pkgs,
    lib,
    ...
}: {
    home-manager.users.soma.programs.thunderbird = {
        enable = true;
        profiles.default.isDefault = true;
        settings = {
            #https://github.com/HorlogeSkynet/thunderbird-user.js
            "datareporting.healthreport.uploadEnabled" = false;
            "layout.css.always_underline_links" = true;
            "mailnews.start_page.enabled" = false;
            "mail.e2ee.auto_enable" = true;
            "mail.e2ee.auto_disable" = true;
            "browser.aboutConfig.showWarning" = false;

            "browser.newtabpage.enabled" = false;

            "geo.provider.use_geoclue" = false;

            "extensions.getAddons.showPane" = false;
            "extensions.htmlaboutaddons.recommendations.enabled" = false;
            "browser.shopping.experience2023.enabled" = false;

            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.server" = "data:,";
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.updatePing.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.coverage.opt-out" = true;
            "toolkit.coverage.opt-out" = true;
            "toolkit.coverage.endpoint.base" = "";

            "app.shield.optoutstudies.enabled" = false;
            "app.normandy.enabled" = false;
            "app.normandy.api_url" = "";

            "breakpad.reportURL" = "";
            "browser.tabs.crashReporting.sendReport" = false;
            "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

            "captivedetect.canonicalURL" = "";
            "network.captive-portal-service.enabled" = false;
            "network.connectivity-service.enabled" = false;
            "mail.instrumentation.postUrl" = "";
            "mail.instrumentation.askUser" = false;
            "mail.instrumentation.userOptedIn" = false;
            "mail.rights.override" = true;
            "app.donation.eoy.version.viewed" = 999;
            "browser.safebrowsing.malware.enabled" = false;
            "browser.safebrowsing.phishing.enabled" = false;
            "browser.safebrowsing.downloads.enabled" = false;
            "browser.safebrowsing.downloads.remote.enabled" = false;

            "network.prefetch-next" = false;
            "network.dns.disablePrefetch" = true;
            "network.dns.disablePrefetchFromHTTPS" = true;
            "network.predictor.enabled" = false;
            "network.predictor.enable-prefetch" = false;
            "network.http.speculative-parallel-limit" = 0;
            "browser.meta_refresh_when_inactive.disabled" = true;

            "network.proxy.socks_remote_dns" = true;
            "network.file.disable_unc_paths" = true;
            "network.gio.supported-protocols" = "";

            "browser.urlbar.speculativeConnect.enabled" = false;
            "browser.urlbar.quicksuggest.enabled" = false;
            "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
            "browser.urlbar.suggest.quicksuggest.sponsored" = false;
            "browser.search.suggest.enabled" = false;
            "browser.urlbar.suggest.searches" = false;
            "browser.urlbar.trending.featureGate" = false;
            "browser.urlbar.addons.featureGate" = false;
            "browser.urlbar.mdn.featureGate" = false;
            "browser.urlbar.weather.featureGate" = false;
            "browser.urlbar.yelp.featureGate" = false;
            "browser.urlbar.clipboard.featureGate" = false;
            "browser.formfill.enable" = false;
            "browser.urlbar.suggest.engines" = false;
            "layout.css.visited_links_enabled" = false;
            "browser.search.separatePrivateDefault" = true;
            "browser.search.separatePrivateDefault.ui.enabled" = true;

            "signon.autofillForms" = false;
            "signon.formlessCapture.enabled" = false;
            "network.auth.subresource-http-auth-allow" = 1;

            "browser.cache.disk.enable" = false;
            "browser.privatebrowsing.forceMediaMemoryCache" = true;
            "media.memory_cache_max_size" = 65536;
            "browser.sessionstore.privacy_level" = 2;
            "toolkit.winRegisterApplicationRestart" = false;
            "browser.shell.shortcutFavicons" = false;
            "mail.imap.use_disk_cache2" = false;

            "security.ssl.require_safe_negotiation" = true;
            "security.tls.enable_0rtt_data" = false;

            "security.OCSP.enabled" = 1;
            "security.OCSP.require" = true;

            "security.cert_pinning.enforcement_level" = 2;
            "security.remote_settings.crlite_filters.enabled" = true;
            "security.pki.crlite_mode" = 2;

            "security.mixed_content.block_display_content" = true;
            "dom.security.https_only_mode" = true;
            "dom.security.https_only_mode_pbm" = true;
            "dom.security.https_only_mode.upgrade_local" = true;
            "dom.security.https_only_mode_send_http_background_request" = false;

            "security.ssl.treat_unsafe_negotiation_as_broken" = true;
            "browser.xul.error_pages.expert_bad_cert" = true;
            "security.warn_entering_weak" = true;
            "security.warn_leaving_secure" = true;
            "security.warn_viewing_mixed" = true;

            "network.http.referer.XOriginTrimmingPolicy" = 2;

            "privacy.userContext.enabled" = true;
            "privacy.userContext.ui.enabled" = true;

            "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
            "media.peerconnection.ice.default_address_only" = true;
            "media.peerconnection.ice.no_host" = true;
            "media.gmp-provider.enabled" = false;

            "dom.disable_window_move_resize" = true;

            "browser.download.start_downloads_in_tmp_dir" = true;
            "browser.uitour.enabled" = false;
            "browser.uitour.url" = "";
            "devtools.debugger.remote-enabled" = false;
            "permissions.manager.defaultsUrl" = "";
            "webchannel.allowObject.urlWhitelist" = "";
            "network.IDN_show_punycode" = true;
            "pdfjs.disabled" = false;
            "pdfjs.enableScripting" = false;
            "browser.tabs.searchclipboardfor.middleclick" = false;
            "browser.contentanalysis.enabled" = false;
            "browser.contentanalysis.default_result" = 0;

            "browser.download.useDownloadDir" = false;
            "browser.download.manager.addToRecentDocs" = false;
            "browser.download.always_ask_before_handling_new_types" = true;

            "privacy.sanitize.sanitizeOnShutdown" = true;
            "privacy.clearOnShutdown.cache" = true;
            "privacy.clearOnShutdown_v2.cache" = true;
            "privacy.clearOnShutdown.downloads" = true;
            "privacy.clearOnShutdown.formdata" = true;
            "privacy.clearOnShutdown.history" = true;
            "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
            "privacy.clearOnShutdown.cookies" = true;
            "privacy.clearOnShutdown.offlineApps" = true;
            "privacy.clearOnShutdown.sessions" = true;
            "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
            "privacy.clearSiteData.cache" = true;
            "privacy.clearSiteData.cookiesAndStorage" = false;
            "privacy.clearSiteData.historyFormDataAndDownloads" = true;

            "privacy.cpd.cache" = true;
            "privacy.clearHistory.cache" = true;
            "privacy.cpd.formdata" = true;
            "privacy.cpd.history" = true;
            "privacy.clearHistory.historyFormDataAndDownloads" = true;
            "privacy.cpd.cookies" = false;
            "privacy.cpd.sessions" = true;
            "privacy.cpd.offlineApps" = true;
            "privacy.clearHistory.cookiesAndStorage" = false;

            "privacy.sanitize.timeSpan" = 0;

            "privacy.resistFingerprinting" = true;
            "privacy.resistFingerprinting.letterboxing" = true;
            "privacy.spoof_english" = 1;
            "browser.link.open_newwindow.restriction" = 0;
            "webgl.disabled" = true;

            "browser.cache.memory.enable" = false;
            "browser.cache.memory.capacity" = 0;
            #"signon.rememberSignons" = false;
            "permissions.memory_only" = true;
            "browser.chrome.site_icons" = false;
            "browser.sessionstore.max_tabs_undo" = 0;
            "browser.urlbar.suggest.history" = false;
            "browser.urlbar.suggest.bookmark" = false;
            "browser.urlbar.suggest.openpage" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.urlbar.maxRichResults" = 0;
            "browser.urlbar.autoFill" = false;
            "browser.taskbar.lists.enabled" = false;
            "browser.taskbar.lists.frequent.enabled" = false;
            "browser.taskbar.lists.recent.enabled" = false;
            "browser.taskbar.lists.tasks.enabled" = false;
            "places.history.enabled" = false;
            "extensions.formautofill.addresses.enabled" = false;
            "extensions.formautofill.creditCards.enabled" = false;
            "dom.popup_allowed_events" = "click dblclick mousedown pointerdown";
            "browser.pagethumbnails.capturing_disabled" = true;

            "mathml.disabled" = true;
            "svg.disabled" = true;
            "gfx.font_rendering.graphite.enabled" = false;
            "javascript.options.asmjs" = false;
            "javascript.options.ion" = false;
            "javascript.options.baselinejit" = false;
            "javascript.options.jit_trustedprincipals" = true;
            "javascript.options.wasm" = false;
            "gfx.font_rendering.opentype_svg.enabled" = false;
            "media.eme.enabled" = false;
            "browser.eme.ui.enabled" = false;
            "network.http.referer.XOriginPolicy" = 2;

            "extensions.blocklist.enabled" = true;
            "network.http.referer.spoofSource" = false;
            "security.dialog_enable_delay" = 1000;
            "privacy.firstparty.isolate" = false;
            "extensions.webcompat.enable_shims" = true;
            "security.tls.version.enable-deprecated" = false;
            "extensions.webcompat-reporter.enabled" = false;
            "extensions.quarantinedDomains.enabled" = true;

            "geo.enabled" = false;
            "full-screen-api.enabled" = false;
            "security.ssl3.ecdhe_ecdsa_aes_256_sha" = false;
            "security.ssl3.ecdhe_ecdsa_aes_128_sha" = false;
            "security.ssl3.ecdhe_rsa_aes_128_sha" = false;
            "security.ssl3.ecdhe_rsa_aes_256_sha" = false;
            "security.ssl3.rsa_aes_128_gcm_sha256" = false;
            "security.ssl3.rsa_aes_256_gcm_sha384" = false;
            "security.ssl3.rsa_aes_128_sha" = false;
            "security.ssl3.rsa_aes_256_sha" = false;
            "security.ssl.disable_session_identifiers" = true;
            "dom.securecontext.allowlist_onions" = true;
            "network.http.referer.hideOnionSource" = true;
            "network.http.sendRefererHeader" = 0;
            "network.http.referer.trimmingPolicy" = 0;
            "network.http.referer.defaultPolicy" = 0;
            "network.http.referer.defaultPolicy.pbmode" = 0;
            "network.http.altsvc.enabled" = false;
            "dom.event.contextmenu.enabled" = false;
            "gfx.downloadable_fonts.enabled" = false;
            "gfx.downloadable_fonts.fallback_delay" = -1;
            "dom.event.clipboardevents.enabled" = false;
            "media.peerconnection.enabled" = false;
            "privacy.globalprivacycontrol.enabled" = true;

            "browser.startup.homepage_override.mstone" = "ignore";
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

            "mail.cloud_files.enabled" = false;
            "pref.privacy.disable_button.view_cookies" = false;
            "pref.privacy.disable_button.cookie_exceptions" = false;
            "pref.privacy.disable_button.view_passwords" = false;

            "mailnews.headers.showSender" = true;
            "mailnews.headers.showUserAgent" = false;
            "mailnews.display.original_date" = false;
            "mailnews.display.date_senders_timezone" = false;
            "mailnews.headers.sendUserAgent" = false;

            "extensions.cardbook.useOnlyEmail" = true;

            "mailnews.reply_header_type" = 1;
            "mailnews.reply_header_authorwrotesingle" = "#1 wrote:";
            "mail.suppress_content_language" = true;
            "mail.sanitize_date_header" = true;

            "mailnews.display.disallow_mime_handlers" = 3;
            "mailnews.display.html_as" = 3;
            "mail.html_sanitize.drop_conditional_css" = true;

            "media.mediasource.enabled" = false;
            "media.hardware-video-decoding.enabled" = false;
            "permissions.default.image" = 2;
            "mail.phishing.detection.enabled" = true;
            "mail.phishing.detection.disallow_form_actions" = true;
            "mail.phishing.detection.ipaddresses" = true;
            "mail.phishing.detection.mismatched_hosts" = true;
            "mailnews.message_display.disable_remote_image" = true;

            "mail.chat.enabled" = false;
            "purple.logging.log_chats" = false;
            "purple.logging.log_ims" = false;
            "purple.logging.log_system" = false;
            "purple.conversations.im.send_typing" = false;
            "mail.chat.notification_info" = 2;

            "calendar.timezone.local" = "UTC";

            "rss.display.disallow_mime_handlers" = 3;
            "rss.display.html_as" = 1;
            "rss.display.prefer_plaintext" = true;
            "rss.show.content-base" = 3;
            "rss.show.summary" = 1;
            "rss.message.loadWebPageOnSelect" = 0;
        };
    };
}
