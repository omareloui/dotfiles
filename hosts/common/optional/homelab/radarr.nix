{
  config,
  lib,
  ...
}: {
  services = {
    radarr = {
      enable = lib.mkDefault false;
      openFirewall = config.services.radarr.enable;
      group = "shared";
    };

    nginx.virtualHosts."radarr.homelab" =
      lib.mkIf config.services.radarr.enable
      {locations."/".proxyPass = "http://localhost:7878";};
  };

  networking.extraHosts = lib.mkIf config.services.radarr.enable "127.0.0.1 radarr.homelab";
}
