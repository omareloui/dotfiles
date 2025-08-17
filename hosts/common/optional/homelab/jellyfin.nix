{
  config,
  lib,
  ...
}: {
  services = {
    jellyfin = {
      enable = false;
      openFirewall = config.services.jellyfin.enable;
      group = "shared";
    };

    nginx.virtualHosts."jellyfin.homelab" =
      lib.mkIf config.services.jellyfin.enable
      {locations."/".proxyPass = "http://localhost:8096";};
  };
}
