{
  lib,
  config,
  ...
}: {
  virtualisation.oci-containers.containers = {
    byparr = {
      autoStart = lib.mkDefault false;
      image = "ghcr.io/thephaseless/byparr:latest";
      ports = ["8191:8191"];
    };
  };

  services.nginx.virtualHosts."byparr.homelab" =
    lib.mkIf config.virtualisation.oci-containers.containers.byparr.autoStart
    {locations."/".proxyPass = "http://localhost:8191";};

  networking.extraHosts = lib.mkIf config.virtualisation.oci-containers.containers.byparr.autoStart "127.0.0.1 byparr.homelab";
}
