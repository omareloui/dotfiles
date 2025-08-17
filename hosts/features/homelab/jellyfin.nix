{
  config,
  lib,
  ...
}: {
  services = {
    jellyfin = {
      enable = false;
      openFirewall = config.services.jellyfin.enable;
      group = "media";
    };

    nginx.virtualHosts."jellyfin.homelab" =
      lib.mkIf config.services.jellyfin.enable
      {locations."/".proxyPass = "http://localhost:8096";};
  };
}
