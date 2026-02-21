{
  config,
  lib,
  ...
}: {
  services = {
    prowlarr = {
      enable = lib.mkDefault false;
      openFirewall = config.services.prowlarr.enable;
    };

    nginx.virtualHosts."prowlarr.homelab" =
      lib.mkIf config.services.prowlarr.enable
      {locations."/".proxyPass = "http://localhost:9696";};
  };

  networking.extraHosts = lib.mkIf config.services.prowlarr.enable "127.0.0.1 prowlarr.homelab";
}
