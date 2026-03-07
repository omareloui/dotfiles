{
  pkgs,
  config,
  lib,
  ...
}: {
  services = {
    transmission = {
      enable = lib.mkDefault false;
      openFirewall = config.services.transmission.enable;
      package = pkgs.transmission_4-gtk;
      group = "shared";
      downloadDirPermissions = "770";
      settings = {
        download-dir = "/home/shared/torrents";
        incomplete-dir = "/home/shared/torrents/.incomplete";
        rpc-whitelist-enabled = true;
        rpc-whitelist = "127.0.0.1,192.168.*.*,172.17.*.*,172.16.*.*";
        rpc-bind-address = "0.0.0.0";
      };
    };

    nginx.virtualHosts."transmission.homelab" =
      lib.mkIf config.services.transmission.enable
      {locations."/".proxyPass = "http://localhost:9091";};
  };

  networking.firewall.allowedTCPPorts = lib.mkIf config.services.transmission.enable [9091];
  networking.extraHosts = lib.mkIf config.services.transmission.enable "127.0.0.1 transmission.homelab";
}
