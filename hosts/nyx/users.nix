{
  config,
  lib,
  ...
}: {
  users = {
    users.omareloui = {isNormalUser = true;};

    groups = {
      shared.members = [
        "omareloui"

        (lib.mkIf config.services.transmission.enable config.services.transmission.user)
        (lib.mkIf config.services.syncthing.enable config.services.syncthing.user)
        (lib.mkIf config.services.bazarr.enable config.services.bazarr.user)
        (lib.mkIf config.services.jellyfin.enable config.services.jellyfin.user)
        (lib.mkIf config.services.radarr.enable config.services.radarr.user)
        (lib.mkIf config.services.sonarr.enable config.services.sonarr.user)
      ];
    };
  };
}
