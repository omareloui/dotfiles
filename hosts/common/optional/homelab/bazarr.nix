{
  config,
  lib,
  ...
}: {
  services = {
    bazarr = {
      enable = lib.mkDefault false;
      openFirewall = config.services.bazarr.enable;
      group = "shared";
    };

    nginx.virtualHosts."bazarr.homelab" = lib.mkIf config.services.bazarr.enable {locations."/".proxyPass = "http://localhost:6767";};
  };

  networking.extraHosts = lib.mkIf config.services.bazarr.enable "127.0.0.1 bazarr.homelab";
}
