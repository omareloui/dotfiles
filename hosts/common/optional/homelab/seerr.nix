{
  config,
  lib,
  ...
}: {
  services = {
    jellyseerr = {
      enable = lib.mkDefault false;
      openFirewall = config.services.jellyseerr.enable;
    };
    nginx.virtualHosts."jellyseerr.homelab" =
      lib.mkIf config.services.jellyseerr.enable
      {locations."/".proxyPass = "http://localhost:5055";};
  };

  networking.extraHosts = lib.mkIf config.services.jellyseerr.enable "127.0.0.1 jellyseerr.homelab";
}
