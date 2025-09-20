{
    config,
    pkgs,
    lib,
    ...
}: {
    services.printing = {
        enable = true;
        drivers = [pkgs.gutenprintBin pkgs.hplip pkgs.gutenprint];
        #drivers = [pkgs.gutenprintBin pkgs.hplip pkgs.gutenprint pkgs.gutenprintBin pkgs.hplip pkgs.hplipWithPlugin pkgs.postscript-lexmark pkgs.samsung-unified-linux-driver pkgs.splix pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper pkgs.cnijfilter2 pkgs.epson-escpr2 pkgs.epson-escpr];
        #drivers = [pkgs.gutenprintBin pkgs.hplip pkgs.gutenprint pkgs.epson-escpr2 pkgs.epson-escpr pkgs.epsonscan2 pkgs.epson_201310w pkgs.epson_201207w pkgs.epson-201401w pkgs.epson-alc1100 pkgs.epson-workforce-635-nx625-series pkgs.epson-inkjet-printer-workforce-840-series];
    };
    services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
    };
    hardware.sane.enable = true;
}
