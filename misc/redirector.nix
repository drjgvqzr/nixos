{
    config,
    pkgs,
    lib,
    ...
}: {
    home-manager.users.soma.programs.librewolf.profiles.default.extensions.settings."redirector@einaregilsson.com".settings = {
        redirects = [
            {
                includePattern = "https://*youtube.com/*";
                redirectUrl = "https://inv.nadeko.net/$2";
                appliesTo = ["main_frame"];
            }
            {
                includePattern = "https://*reddit.com/*";
                excludePattern = "https://old.reddit.com*|*preview.redd.it*";
                redirectUrl = "https://old.reddit.com/$2";
                appliesTo = ["main_frame"];
            }
            {
                includePattern = "https://x.com/*";
                redirectUrl = "https://xcancel.com/$1";
                appliesTo = ["main_frame"];
            }
            {
                includePattern = "https://inv.nadeko.net/feed/popular";
                redirectUrl = "https://inv.nadeko.net/search";
                appliesTo = ["main_frame"];
            }
            #{
            #    includePattern = "https://*.fandom.com/wiki/*";
            #    redirectUrl = "https://breezewiki.com/$1/wiki/$2";
            #    appliesTo = ["main_frame"];
            #}
            #{
            #    includePattern = "https://github.com/*/*";
            #    excludePattern = "*/issues*|*/raw*|*/wiki*|*/releases*|*/discussions*|*/pull*|*/topics*";
            #    redirectUrl = "https://gothub.lunar.icu/$1/$2";
            #    appliesTo = ["main_frame"];
            #}
            {
                includePattern = "https://en.wikipedia.org/wiki/*";
                excludePattern = "*?useskin=minerva#bodyContent|*#*";
                redirectUrl = "https://en.wikipedia.org/wiki/$1?useskin=minerva#bodyContent";
                appliesTo = ["main_frame"];
            }
            {
                includePattern = "https://wiki.archlinux.org/*";
                excludePattern = "*?useskin=vector#bodyContent|*anubis*|*#*";
                redirectUrl = "https://wiki.archlinux.org/$1?useskin=vector#bodyContent";
                appliesTo = ["main_frame"];
            }
        ];
    };
}
