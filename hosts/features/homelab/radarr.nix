{
  config,
  lib,
  ...
}: {
  services = {
    radarr = {
      enable = false;
      openFirewall = config.services.radarr.enable;
      group = "shared";
    };

    nginx.virtualHosts."radarr.homelab" =
      lib.mkIf config.services.radarr.enable
      {
        locations."/".proxyPass = "http://localhost:7878";
      };
  };
}
