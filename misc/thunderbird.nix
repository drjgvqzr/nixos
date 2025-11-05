{
    config,
    pkgs,
    lib,
    ...
}: {
    home-manager.users.soma.programs.thunderbird = {
        enable = false;
        profiles.default.isDefault = true;
    };
}
