{
  lib,
  config,
  ...
}: {
  virtualisation.oci-containers.containers = {
    homarr = {
      autoStart = lib.mkDefault false;
      image = "ghcr.io/ajnart/homarr:latest";
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/home/omareloui/.config/homarr/configs:/app/data/configs"
        "/home/omareloui/.config/homarr/icons:/app/public/icons"
        "/home/omareloui/.config/homarr/data:/data"
      ];
      ports = ["7575:7575"];
    };
  };

  services.nginx.virtualHosts."homarr.homelab" =
    lib.mkIf config.virtualisation.oci-containers.containers.homarr.autoStart
    {locations."/".proxyPass = "http://localhost:7575";};

  networking.extraHosts = lib.mkIf config.virtualisation.oci-containers.containers.homarr.autoStart "127.0.0.1 homarr.homelab";
}
