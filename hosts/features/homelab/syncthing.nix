{
  config,
  lib,
  ...
}: {
  services = {
    syncthing = {
      enable = true;
      openDefaultPorts = config.services.syncthing.enable;
      group = "media";
    };

    nginx.virtualHosts."syncthing.homelab" =
      lib.mkIf config.services.syncthing.enable
      {locations."/".proxyPass = "http://localhost:8384";};
  };
}
