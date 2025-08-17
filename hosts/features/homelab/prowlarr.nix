{
  config,
  lib,
  ...
}: {
  services = {
    prowlarr = {
      enable = false;
      openFirewall = config.services.prowlarr.enable;
    };

    nginx.virtualHosts."prowlarr.homelab" =
      lib.mkIf config.services.prowlarr.enable
      {locations."/". proxyPass = "http://localhost:9696";};
  };
}
