{
  config,
  lib,
  ...
}: {
  services = {
    jellyfin = {
      enable = lib.mkDefault false;
      openFirewall = config.services.jellyfin.enable;
      group = "shared";
    };

    nginx.virtualHosts."jellyfin.homelab" =
      lib.mkIf config.services.jellyfin.enable
      {locations."/".proxyPass = "http://localhost:8096";};
  };

  networking.extraHosts = lib.mkIf config.services.jellyfin.enable "127.0.0.1 jellyfin.homelab";
}
