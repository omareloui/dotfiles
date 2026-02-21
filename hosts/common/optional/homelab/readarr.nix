{
  config,
  lib,
  ...
}: {
  services = {
    readarr = {
      enable = lib.mkDefault false;
      openFirewall = config.services.readarr.enable;
      group = "shared";
    };

    nginx.virtualHosts."readarr.homelab" =
      lib.mkIf config.services.readarr.enable
      {locations."/".proxyPass = "http://localhost:8787";};
  };

  networking.extraHosts = lib.mkIf config.services.readarr.enable "127.0.0.1 readarr.homelab";
}
