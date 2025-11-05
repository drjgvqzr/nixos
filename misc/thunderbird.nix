{
    config,
    pkgs,
    lib,
    ...
}: {
    home-manager.users.soma.programs.thunderbird = {
        enable = true;
        profiles.default.isDefault = true;
    };
}
