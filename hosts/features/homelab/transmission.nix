{
  pkgs,
  config,
  lib,
  ...
}: {
  services = {
    transmission = {
      enable = true;
      openFirewall = config.services.transmission.enable;
      package = pkgs.transmission_4-gtk;
      # settings = {
      #   download-dir = "/home/media/torrents";
      #   incomplete-dir = "/home/media/torrents/.incomplete";
      # };
    };

    nginx.virtualHosts."transmission.homelab" =
      lib.mkIf config.services.transmission.enable
      {locations."/". proxyPass = "http://localhost:9091";};
  };
}
