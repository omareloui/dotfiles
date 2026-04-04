{
  config,
  lib,
  ...
}: {
  services = {
    seerr = {
      enable = lib.mkDefault false;
      openFirewall = config.services.seerr.enable;
    };
    nginx.virtualHosts."seerr.homelab" =
      lib.mkIf config.services.seerr.enable
      {locations."/".proxyPass = "http://localhost:5055";};
  };

  networking.extraHosts = lib.mkIf config.services.seerr.enable "127.0.0.1 seerr.homelab";
}
