{
  config,
  lib,
  ...
}: {
  services = {
    flaresolverr = {
      enable = lib.mkDefault false;
      openFirewall = config.services.flaresolverr.enable;
      group = "shared";
    };

    nginx.virtualHosts."flaresolverr.homelab" =
      lib.mkIf config.virtualisation.oci-containers.containers.homarr.autoStart
      {locations."/".proxyPass = "http://localhost:6767";};
  };

  networking.extraHosts = lib.mkIf config.services.flaresolverr.enable "127.0.0.1 flaresolverr.homelab";
}
