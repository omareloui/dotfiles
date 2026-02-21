{
  config,
  lib,
  ...
}: {
  services = {
    sonarr = {
      enable = lib.mkDefault false;
      openFirewall = config.services.sonarr.enable;
      group = "shared";
    };

    nginx.virtualHosts."sonarr.homelab" =
      lib.mkIf config.services.sonarr.enable
      {locations."/".proxyPass = "http://localhost:8989";};
  };

  networking.extraHosts = lib.mkIf config.services.sonarr.enable "127.0.0.1 sonarr.homelab";
}
